console.log("member modify in");

document.getElementById('nickName').addEventListener('blur', () =>{
    EmptyCheck(document.getElementById('nickName').value);
})

function EmptyCheck(Val){
    if(Val == null && Val == ''){
        document.getElementById('modBtn').setAttribute('disabled', 'disabled'); 
    }else{
        document.getElementById('modBtn').removeAttribute('disabled');
    }
}


document.addEventListener('input', (e)=>{
    console.log(e.target);
    if(e.target.classList.contains('pwd')){
        let pwd = document.getElementById('pwd-Check1').value;
        console.log(pwd);
        let pwdcheck = document.getElementById('pwd-Check2').value;
        console.log(pwdcheck);
        //비밀번호 비교
        passWordCompare(pwd, pwdcheck);
    }else if(e.target.classList.contains('nick').value === ''){
        document.getElementById('modBtn').setAttribute('disabled', 'disabled');
    }else if(e.target.classList.contains('nick').value !== ''){
        document.getElementById('modBtn').removeAttribute('disabled');
    }

})

//비밀번호 비교 후 구문 변화
function passWordCompare(pwd, pwdcheck){
    if(passWordCheck(pwd, pwdcheck)){
        document.getElementById('pwd_check').setAttribute('hidden', 'hidden');
        console.log('passWordCheck isOk');
        document.getElementById('modBtn').removeAttribute('disabled');
        return true;
    }else{
        document.getElementById('pwd_check').removeAttribute('hidden');
        console.log('passWordCheck isFail');
        
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