// Declaraçõ de variáveis
var x = 5;
var y = 6;
// Função
function soma() {
    if (x > 0) {
        return x + y;
    }
}

// Chamada da função

soma();
// Função anônima (arrow function)
const somar = () => { return x + y };
soma();