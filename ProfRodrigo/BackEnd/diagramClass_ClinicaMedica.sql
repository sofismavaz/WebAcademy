%% Arquivo: BackEnd/diagramClass_ClinicaMedica.mmd
%%// Descrição: Diagrama de classes para o sistema de gestão de clínica médica
%%// Autor: ChatGPT, sob as orientações do Lucir Vaz
%%// Data: 2024-06-15
%% WebAcademy - Curso de UML/Backend com Java


diagramClass
ClinicaMedica {
    nome char(100)
    endereco char(100)
    telefone char(15)
    cnpj char(18)
    idMedicos char(10)
    idPacientes char(10)
    idConsultas char(10)
    idExames char(10)
    idFuncionarios char(10)
}

Paciente{
    id char(10)
    nome char(100)
    email char(100)
    cpf char(11)
    dataNascimento date
    grupoSanguineo char(3)
    sexo char(1)
    telefone char(15)
    endereco char(100)
    cep char(10)
    cidade char(100)
    estado
}
Medico {
    id char(10)
    nome char(100)
    especialidade char(100)
    crm char(10)
    telefone char(15)
    email char(100)
}
Atendimento {
    id char(10)
    data date
    hora time
    motivo char(255)
    diagnostico char(255)
    prescricao char(255)
    receita char(255)
}
Consulta {
    id char(10)
    data date
    hora time
    status char(20)
    paciente char(10)
    medico char(10)
    atendimento char(10)
}
Exame {
    id char(10)
    tipo char(100)
    data date
    resultado char(255)
    consulta char(10)
    paciente char(10)
    medico char(10)
}
Funcionario {
    id char(10)
    nome char(100)
    cargo char(100)
    telefone char(15)
    email char(100) 
}