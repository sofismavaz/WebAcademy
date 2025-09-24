/* criar uma classe chamada Mag
   que tenha um atributo chamado nome
   e um método chamado exibirNome que exibe o nome da mágica
   criar um objeto da classe Mag e chamar o método exibirNome */
   <?php
   class Mag {
       public (
        $nome; 
        $cpf;
        $idade;
        $endereco;
        $telefone;
        )

       public function __construct($nome, $cpf, $idade, $endereco, $telefone) {
           $this->nome = $nome;
           $this->cpf = $cpf;
           $this->idade = $idade;
           $this->endereco = $endereco;
           $this->telefone = $telefone;
       }

       public function exibirNome() {
           echo "O nome da mágica é: " . $this->nome;
       }
   }

   $magica = new Mag("Ilusionismo");
   $magica->exibirNome();
   ?>