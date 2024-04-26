import axiosInstance from "./api";
import TokenService from "./token.service";
import { refreshToken } from "../actions/auth";
const jsonwebtoken = require('jsonwebtoken');

/* const jwtSecret = '.:Lo perfecto es enemigo de lo bueno:.'; */

const jwtSecret = 'T1RNNE5UVTVNVEZsT1RGa056SmlPRGcyWWpoalpUQXlOalUwT1RGbU1EUTRaVEZpWmpBeU5ESm1aamhtTm1SbU1HTXdZVGd3TVRoaU4yWmhORFpoT0E9PQ==';
const jwtAlgorithm = 'HS512';

const setup = (store) => {
  axiosInstance.interceptors.request.use(
    (config) => {
      const token = TokenService.getLocalAccessToken();
      if (token) {
      config.headers["Authorization"] = 'Bearer ' + token;  // for Spring Boot back-end
       //config.headers["x-access-token"] = token; // for Node.js Express back-end

      }

        //acrajovi
      const data = config.data;

      console.log('data', data);
       
       const encryptedString = jsonwebtoken.sign(JSON.stringify(data), atob(atob(jwtSecret)),  { algorithm: jwtAlgorithm });

       config.headers["Token"]=encryptedString;
      
      // config.data=JSON.parse('Hola Mundo');

      config.data='{"Hola":"Mundo"}';

      return config;
    },
    (error) => {
      return Promise.reject(error);
    }
  );

  const { dispatch } = store;

  axiosInstance.interceptors.response.use(
    (res) => {
 
      console.log('_____Token:', res.headers.token);
        const verifySign= jsonwebtoken.verify(res.headers.token, atob(atob(jwtSecret)),  { algorithm: jwtAlgorithm });
        console.log('verifySign:', verifySign); 
      

  //  res = verifySign.JSON;
  //  console.log('res:', res); 
       
    return verifySign;
    },
    async (err) => {
      const originalConfig = err.config;

      if (originalConfig.url !== "/auth/signin" && err.response) {
        // Access Token was expired
        if (err.response.status === 401 && !originalConfig._retry) {
          originalConfig._retry = true;

          try {
            const rs = await axiosInstance.post("/auth/refreshtoken", {
              refreshToken: TokenService.getLocalRefreshToken(),
            });

            const { accessToken } = rs.data;

            dispatch(refreshToken(accessToken));
            TokenService.updateLocalAccessToken(accessToken);

            return axiosInstance(originalConfig);
          } catch (_error) {
            return Promise.reject(_error);
          }
        }
      }

      return Promise.reject(err);
    }
  );
};

export default setup;
