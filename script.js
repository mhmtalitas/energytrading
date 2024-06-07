function analyzeCode() {
    const code = document.getElementById('contractCode').value;
    const resultsDiv = document.getElementById('results');
    let issues = [];

    if (code.includes('.call{')) {
        issues.push("Potential reentrancy vulnerability found with '.call' usage.");
    }
    if (code.match(/(\+=|-=|\*=|\/=|%=)/) && !code.match(/safeMath/i)) {
        issues.push("Potential integer overflow/underflow detected. Consider using SafeMath.");
    }
    if (code.includes('call.value(') && !code.includes('require')) {
        issues.push("Unchecked low-level call detected. Ensure proper checks and error handling.");
    }

    resultsDiv.innerHTML = issues.length ? '<ul>' + issues.map(issue => `<li>${issue}</li>`).join('') + '</ul>' : 'No security issues found.';
}
