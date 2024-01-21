console.log("comment js in~");
console.log(bnoVal);
try {
    console.log(emailVal);
} catch (error) {
    
}

document.getElementById('cmtPostBtn').addEventListener('click', ()=>{
    const cmtText = document.getElementById('cmtText');
    if(cmtText.value == null || cmtText.value == ''){
        alert('댓글을 입력해주세요.');
        cmtText.focus();
        return false;
    }else{
        let cmtData = {
            bno: bnoVal,
            writer: document.getElementById('cmtWriter').innerText,
            content: cmtText.value
        };
        console.log(cmtData);
        //서버에 비동기로 보내기
        postCommentToServer(cmtData).then(result =>{
            if(result == '1'){
                alert("댓글 등록 성공~!!");
                cmtText.value="";
            }
            //화면에 뿌리기
            spreadCommentList(cmtData.bno);
        })
    }
})

async function postCommentToServer(cmtData){
    try {
        const url = "/comment/post"
        const config = {
            method: "post",
            headers: {
                'content-type' : 'application/json; charset=utf-8'
            },
            body: JSON.stringify(cmtData)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

async function getCommentListFromServer(bno, page){
    try {
        const resp = await fetch("/comment/"+bno+"/"+page);
        const result = await resp.json(); //commentList return
        return result;
    } catch (error) {
        console.log(error);
    }
}

function spreadCommentList(bno, page=1){
    getCommentListFromServer(bno, page).then(result => {
        console.log(result);
        //댓글 모양대로 뿌리기
        if(result.cmtList.length > 0){
            const ul = document.getElementById('cmtListArea');
            //댓글을 다시 뿌릴때 기존값을 삭제 x 1page일 경우만 삭제
            if(page==1){
                ul.innerHTML = '';
            }
            for(let cvo of result.cmtList){
                let li = `<li class="list-group-item" id="${cvo.cno}" data-cno="${cvo.cno}" data-writer="${cvo.writer}">`;
                li += `<div class="mb-3">`;
                li += `<div class="fw-bold">${cvo.writer}</div>`;
                li += `${cvo.content}`;
                li += `</div>`;
                li += `<span class="badge rounded-pill text-bg-warning">${cvo.modAt}</span>`;
                li += `&nbsp<button type="button" id="${cvo.cno}-modBtn" class="btn btn-outline-warning mod btn-sm" data-bs-toggle="modal" data-bs-target="#myModal" hidden>e</button>`;
                li += `&nbsp<button type="button" id="${cvo.cno}-delBtn" class="btn btn-outline-danger del btn-sm" hidden>x</button>`;
                li += `</li>`;
                ul.innerHTML += li;
                checkWriter(cvo.writer, cvo.cno, emailVal);
            }
            
            //더보기 버튼 코드
            let moreBtn = document.getElementById('moreBtn');
            console.log(moreBtn);
            //more 버튼 표시 조건
            if(result.pgvo.pageNo < result.endPage){
                moreBtn.style.visibility = 'visible'; //버튼 표시
                moreBtn.dataset.page = page+1;
            }else{
                moreBtn.style.visibility = 'hidden'; //버튼 숨김
            }
         }else{
             const ul = document.getElementById('cmtListArea');
             let li = `<li class="list-group-item">Comment List Empty</li>`;
             ul.innerHTML += li;
         }
        
     })
 };
 
 document.addEventListener('click', (e) =>{
    console.log(e.target);
    if(e.target.id === 'moreBtn'){
        let page = parseInt(e.target.dataset.page);
        spreadCommentList(bnoVal, page);
    }else if(e.target.classList.contains('mod')){
        let li = e.target.closest('li');
        console.log(li);
        //nextSibling : 한 부모 안에서 같은 형제 찾기
        let cmtText = li.querySelector('.fw-bold').nextSibling;
        console.log(cmtText);
        //모달창에 기존 댓글 내용을 반영 (수정하기 편하게...)
        document.getElementById('cmtTextMod').value = cmtText.nodeValue;

        //수정 => cno, writer, content를 위한 cno, writer data- 로 달기
        document.getElementById('cmtModBtn').setAttribute("data-cno", li.dataset.cno);
        document.getElementById('cmtModBtn').setAttribute("data-writer", li.dataset.writer);
    }else if(e.target.id == 'cmtModBtn'){
        let cmtDataMod={
            cno: e.target.dataset.cno,
            writer: e.target.dataset.writer,
            content: document.getElementById('cmtTextMod').value
        };
        console.log(cmtDataMod);
        //비동기로 보내기
        editCommentToServer(cmtDataMod).then(result=>{
            if(result == '1'){
                //댓글 수정 성공
                //모달창을 닫기
                alert("댓글 수정 완료");
                document.querySelector('.btn-close').click();
            }else{
                //댓글 수정 실패
                alert("댓글 수정 실패");
                //모달창을 닫기
                document.querySelector('.btn-close').click();
            }
            //수정된 댓글 뿌리기 page=1
            spreadCommentList(bnoVal);
        })
    }else if(e.target.classList.contains('del')){
        let li = e.target.closest('li');
        let cno = li.dataset.cno;
        let writer = li.dataset.writer;
        console.log("cno"+cno+", writer"+writer)
        //비동기로 보내기
        deleteCommentToServer(cno, writer).then(result=>{
            if(result == '1'){
                alert("댓글 삭제 성공");
                li.remove();
            }else{
                alert("댓글 삭제 실패");
            }
	        spreadCommentList(bnoVal);
        });
    }
 })

 //댓글 수정 비동기
 async function editCommentToServer(cmtDataMod){
    try {
        const url = '/comment/edit';
        const config={
            method:'put',
            headers:{
                'content-type' : 'application/json; charset=utf-8'
            },
            body: JSON.stringify(cmtDataMod)
        };
        const resp = await fetch(url, config);
        const result = resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

//댓글 삭제 비동기
async function deleteCommentToServer(cno, writer){
    try {
        const url = '/comment/delete/'+cno+"/"+writer;
        const config={
            method:'delete'
        };
        const resp = await fetch(url, config);
        const result = resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

//댓글마다 아이디 맞으면, 수정, 삭제 버튼 나타내기
function checkWriter(cvoWriter, cno, emailVal){
    getWriterToServer(cvoWriter, cno).then(result =>{
        console.log("id check sucess");
        let cnoli = document.getElementById(cno);
        console.log(cnoli);
        let modBtn = document.getElementById(cno+"-modBtn");
        console.log(modBtn);
        let delBtn = document.getElementById(cno+"-delBtn");
        console.log(delBtn);
        if(result == emailVal){
            console.log("id check isOk");
            modBtn.removeAttribute('hidden');
            delBtn.removeAttribute('hidden');
        }else{
            console.log("id check isFail");
            modBtn.setAttribute('hidden', 'hidden');
            delBtn.setAttribute('hidden', 'hidden');
        }
    })
}

//각 댓글의 작성자 가져오는 비동기 
async function getWriterToServer(cvoWriter, cno){
    try {
        const url = '/comment/writer/'+cvoWriter+"/"+cno;
        const config = {
            method: 'get'
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}
