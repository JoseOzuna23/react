import api from "./api";
import TokenService from "./token.service";
import ArapySecurityUtil from '../helpers/arapySecurityUtil';

class AuthService {

  login(uname, passwd) {
    console.log('____password:'+passwd);
    let password= ArapySecurityUtil.getHashedPassword(passwd);
    let username= ArapySecurityUtil.getHashedPassword(uname);
    console.log('___hashedPassword:'+password);
    return api
      .post("/auth/signin", {
        username,
        password
      })
      .then(response => {
        const data = JSON.stringify(response);
        console.log('_______---data:'+data);

        if (response.accessToken) {
          TokenService.setUser(response);
        }

        return response;
      });
  }

  logout() {
    TokenService.removeUser();
  }

  register(username, email, password) {
    return api.post("/auth/signup", {
      username,
      email,
      password
    });
  }
}

export default new AuthService();
