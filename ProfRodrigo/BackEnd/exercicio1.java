package BackEnd;

public class exercicio1 {
    public static void main(String[] args) {
        // limpar a tela
        System.out.println("\033[H\033[2J");
        System.out.flush();

        // criar var integer
        int numero = 10;
        
        // criar var double
        double decimal = 10.5;
        
        // criar var string
        String texto = "Hello, World!";
        
        // criar var boolean
        boolean verdadeiro = true;
        
        // criar var char
        char caractere = 'A';
        
        // criar var array de integer
        int[] numeros = {1, 2, 3, 4, 5};
        
        // criar var array de string
        String[] textos = {"Hello", "World"};
                
        // criar var array de boolean
        boolean[] booleanos = {true, false, true};
        
        // criar var long
        long numeroLongo = 100000L;
        
        // criar var float
        float numeroFloat = 10.5f;
        
        System.out.println("-------------------------------");
        // mostrar todas as variaveis no console
        System.out.println("Integer: " + numero);
        System.out.println("Double: " + decimal);
        System.out.println("String: " + texto);
        System.out.println("Boolean: " + verdadeiro);
        System.out.println("Char: " + caractere);
        System.out.println("Long: " + numeroLongo);
        System.out.println("Float: " + numeroFloat);
    }
}
