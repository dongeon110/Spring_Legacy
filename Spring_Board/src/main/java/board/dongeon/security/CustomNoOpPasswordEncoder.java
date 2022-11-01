package board.dongeon.security;

import lombok.extern.log4j.Log4j;
import org.springframework.security.crypto.password.PasswordEncoder;

@Log4j
public class CustomNoOpPasswordEncoder implements PasswordEncoder {

    public String encode(CharSequence rawPassword) {
        log.warn("before encode: " + rawPassword);
        return rawPassword.toString();
    }
    
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        // matches() 는 내부에서 평문 패스워드와 암호화된 패스워드가 같은 패스워드인지 아닌지를 반환
        log.warn("matches: " + rawPassword + ":" + encodedPassword);
        return rawPassword.toString().equals(encodedPassword);
    }
}
