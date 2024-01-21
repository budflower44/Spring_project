console.log("member register in");

document.addEventListener('input', (e)=>{
    console.log(e.target);
    if(e.target.classList.contains('pwd')){
        let pwd = document.getElementById('pwd-Check1').value;
        console.log(pwd);
        let pwdcheck = document.getElementById('pwd-Check2').value;
        console.log(pwdcheck);
        //비밀번호 비교
        passWordCompare(pwd, pwdcheck);
    }

})

//비밀번호 비교 후 구문 변화
function passWordCompare(pwd, pwdcheck){
    if(passWordCheck(pwd, pwdcheck)){
        document.getElementById('pwd_check').setAttribute('hidden', 'hidden');
        console.log('passWordCheck isOk');
        document.getElementById('regBtn').removeAttribute('disabled');
        return true;
    }else{
        document.getElementById('pwd_check').removeAttribute('hidden');
        console.log('passWordCheck isFail');
        document.getElementById('regBtn').setAttribute('disabled', 'disabled');
        return false;
    }
}

//비밀번호 일치 체크
function passWordCheck(pwd, pwdcheck){
    if(pwd === pwdcheck){
        return true;
    }else{
        return false;
    }
}

//아이디 중복 체크
document.getElementById('email').addEventListener('input', (e)=>{
    let email = e.target.value;
    console.log("email >> "+email);
    emailCheckToServer(email).then(result=>{
        if(result === '1'){
            document.getElementById('email_check_sucess').removeAttribute('hidden');
            document.getElementById('email_check').setAttribute('hidden', 'hidden');
            document.getElementById('regBtn').removeAttribute('disabled');
        }else{
            document.getElementById('email_check_sucess').setAttribute('hidden', 'hidden');
            document.getElementById('email_check').removeAttribute('hidden');
            document.getElementById('email').value = "";
            document.getElementById('regBtn').setAttribute('disabled', 'disabled');
        }
    })
})

//비동기 아이디 체크 
async function emailCheckToServer(email){
    try {
        const url = "/member/emailCheck/"+email;
        const config = {
            method:'get'
        };
        let resp = await fetch(url, config);
        let result = await resp.text();
        return result;   
    } catch (error) {
        console.log(error);
    }
}

document

