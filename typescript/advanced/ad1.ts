// In typescript, null and undefined can be assigned to any type
function trimAndLower(text: string) {
    return text.trim().toLowerCase();
}
console.log(trimAndLower(null))