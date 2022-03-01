# login.defs option
type Login_Defs::Option = Struct[
  {
    Optional['comment'] => String,
    Optional['enabled'] => Boolean,
    'value'             => Variant[String, Integer],
  }
]
