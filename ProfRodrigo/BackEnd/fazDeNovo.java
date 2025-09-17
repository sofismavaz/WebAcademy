package BackEnd;

// como incluir biblioteca de input do java
import java.util.Scanner;



public class fazDeNovo {
    public static void main(String[] args) {
        //traçar uma linha reta de um ponto a até um ponto b, com caracter *
        var caractere = "#-*-";

        for (int j = 0; j <= 1; j++) {
            int a = 0;
            int b = 20;

            for (int i = a; i <= b; i++) {
                System.out.print(caractere);
            }
        
            System.out.println(); // pular linha
            // habiliatar inserçãode registros e pedir que seja inserido um nome e dizer "olá, nome"
            Scanner scanner = new Scanner(System.in);
            System.out.print("Digite seu nome: ");
            String nome = scanner.nextLine();
            System.out.println("Olá, " + nome + "!");
        }

        
        // pedir que seja inserida a idade de uma pessoa e dizer se ela é maior ou menor de idade
        int idade = 20; // exemplo de idade
        
        // verificar se é maior ou menor de idade
        if (idade >= 18) {
            System.out.println("Maior de idade");
        } else {
            System.out.println("Menor de idade");
        }
        // fazer um laço de repetição, que:
        // peça a nota do aluno1, aluno2, aluno3
        // se a nota for maior ou igual a 6, diga aprovado;
        for (int i = 1; i <= 3; i++) {
            double nota = 7.0; // exemplo de nota
            if (nota >= 6.0) {
                System.out.println("Aprovado");
            } else {
                System.out.println("Reprovado");
            }    
        }
    }
}
