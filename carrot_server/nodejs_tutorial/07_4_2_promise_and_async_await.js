// 프로미스 기본 사용법 ---------------------------------
const myPromise = new Promise((resolve, reject) => {
    const condition = true;
    if (condition) {
        resolve('Promise 성공');
    } else {
        reject('Promise 실패');
    }
});

myPromise.then((message) => {
    console.log(message); // 성공
}).catch((error) => {
    console.error(error); // 실패
});

// 프로미스 체이닝 ---------------------------------
function fetchData() {
    return new Promise((resolve) => setTimeout(() => resolve('Data Received'), 1000));
}

function processData(data) {
    return new Promise((resolve) => setTimeout(() => resolve(`Processed: ${data}`), 1000));
}   

fetchData()
    .then(processData)
    .then(console.log)
    .catch((error) => console.error(error));

// async/await ---------------------------------
async function fetchDataAndProcess() {
    try {
        const data = await fetchData();
        const processedData = await processData(data);
        console.log(processedData);
    } catch (err) {
        console.error(err);
    }
}

fetchDataAndProcess();