# TypeProf 0.21.3

# Classes
module CrypticResolver
  GEM_VERSION: String

  class Resolver
    DEFAULT_LIB_PATH: String
    ORIGINAL_DEFAULT_DICTS: [String, String, String, String, String]
    RECOMMENDED_DICTS: String
    @def_dicts: [String, String, String, String, String]
    @extra_lib_path: nil
    @def_dicts_user_and_names: Array[String]
    @def_dicts_names: Array[String?]

    def bold: (untyped str) -> String
    def underline: (untyped str) -> String
    def red: (untyped str) -> String
    def green: (untyped str) -> String
    def yellow: (untyped str) -> String
    def blue: (untyped str) -> String
    def purple: (untyped str) -> String
    def cyan: (untyped str) -> String
    def initialize: -> void
    def is_there_any_dict?: -> bool
    def add_default_dicts_if_none_exists: -> bool
  end
end
