sealed class IPRException {
  IPRException({
    this.message = "Falha no servidor, por favor tente mais tarde.",
  });
  String message;
}

class TooManyAttemptsException extends IPRException {
  @override
  TooManyAttemptsException({
    super.message = 'Acesso bloqueado temporariamente. Tente mais tarde.',
  });
}

class DataException extends IPRException {
  @override
  DataException({super.message = "Dado inválido."});
}

class BadRequestPRException extends IPRException {
  @override
  BadRequestPRException({
    super.message = "Falha ao tentar acessar. Por favor tente mais tarde",
  });
}

class DuplicatePRException extends IPRException {
  @override
  DuplicatePRException({super.message = "O convidado já está na festa"});
}
