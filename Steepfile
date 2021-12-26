# frozen_string_literal: true

target :app do
  check 'app'
  check 'lib'

  signature 'sig'
  repo_path 'vendor/rbs/gem_rbs_collection/gems'

  libs = %w[
    pathname
    logger
    mutex_m
    date
    monitor
    singleton
    tsort
    securerandom
    base64
    forwardable
    time
    json
    rack
    activesupport
    actionpack
    activejob
    activemodel
    actionview
    activerecord
    railties
    openssl
    net-http
    uri
    nokogiri
  ]
  library(*libs)

  # nil の場合は無視する
  hint = :hint
  # info = :infomation
  # warn = :warning
  error = :error

  steep = ::Steep::Diagnostic::Ruby
  configs =
    {
      steep::ArgumentTypeMismatch => error,
      steep::BlockBodyTypeMismatch => error,
      steep::BlockTypeMismatch => error,
      steep::BreakTypeMismatch => error,
      steep::DifferentMethodParameterKind => error,
      steep::ElseOnExhaustiveCase => error,
      steep::FallbackAny => error,
      steep::ImplicitBreakValueMismatch => error,
      steep::IncompatibleAnnotation => error,
      steep::IncompatibleAssignment => error,
      steep::IncompatibleMethodTypeAnnotation => error,
      steep::IncompatibleTypeCase => error,
      steep::InsufficientKeywordArguments => error,
      steep::InsufficientPositionalArguments => error,
      steep::MethodArityMismatch => error,
      steep::MethodBodyTypeMismatch => error,
      # sig で宣言した method が実装されていない場合は無視
      steep::MethodDefinitionMissing => nil,
      steep::MethodParameterMismatch => error,
      steep::MethodReturnTypeAnnotationMismatch => error,
      steep::NoMethod => error,
      steep::RequiredBlockMissing => hint,
      steep::ReturnTypeMismatch => error,
      steep::SyntaxError => error,
      steep::UnexpectedBlockGiven => error,
      steep::UnexpectedDynamicMethod => error,
      steep::UnexpectedError => error,
      steep::UnexpectedJump => error,
      steep::UnexpectedJumpValue => error,
      steep::UnexpectedKeywordArgument => error,
      steep::UnexpectedPositionalArgument => error,
      steep::UnexpectedSplat => error,
      steep::UnexpectedSuper => error,
      steep::UnexpectedYield => error,
      steep::UnknownConstantAssigned => error,
      steep::UnresolvedOverloading => error,
      steep::UnsatisfiableConstraint => error,
      steep::UnsupportedSyntax => error
    }

  configure_code_diagnostics(configs)
end
