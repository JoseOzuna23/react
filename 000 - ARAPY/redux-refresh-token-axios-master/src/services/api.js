import axios from "axios";

const instance = axios.create({
  baseURL: "http://localhost:8080/arapy/api",
  headers: {
    "Content-Type": "application/json",
  },
});

export default instance;
