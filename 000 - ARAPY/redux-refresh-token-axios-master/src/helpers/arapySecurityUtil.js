const shajs = require('sha.js')

class ArapySecurityUtil{
    getHashedPassword(password) {
        return shajs('sha256').update(password).digest('hex');
      }  
}

export default new ArapySecurityUtil();