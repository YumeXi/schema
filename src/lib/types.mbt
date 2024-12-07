///|
pub typealias Either[L, R] = @utils.Either[L, R]

///|
pub(all) struct Schema {
  mut typ : Either[String, Array[String]]
  keywords : Map[String, Keyword]
} derive(Eq, Show)

///|
pub(all) struct Keyword {
  /// The keyword name
  name : String
  data : KeywordData
} derive(Show, Eq)

///|
pub(all) enum KeywordData {
  // The structure
  Schema(JsonPointer)
  Id(JsonPointer)
  Ref(JsonPointer)
  Defs(Map[String, Schema])
  Anchor(String)
  // The generic keywords
  // Title(String)
  // Description(String)
  // Comment(String)
  // Default(Json)
  // Deprecated(Bool)
  // ReadOnly(Bool)
  // WriteOnly(Bool)
  Type(Either[String, Array[String]])
  Enum(Array[Json])
  Const(Json)
  Default(Json)

  // The string-specific keywords
  MinLength(Int)
  MaxLength(Int)
  Pattern(String)
  Format(String)

  // The numeric-specific keywords
  Minimum(Double)
  Maximum(Double)
  ExclusiveMinimum(Double)
  ExclusiveMaximum(Double)
  MultipleOf(Double)

  // The object-specific keywords
  Required(Array[String])
  DependentRequired(Map[String, Array[String]])
  DependentSchemas(Map[String, Schema])
  Properties(Map[String, Schema])
  AdditionalProperties(Either[Bool, Schema])
  MinProperties(Int)
  MaxProperties(Int)

  // The array-specific keywords
  Items(Schema)
  PrefixItems(Array[Schema])
  UnevaluatedItems(Schema)
  // TODO: Taken place of by `Items` after draft 2020-12, how to handle?
  /// @alert deprecated "Use `Items` instead"
  AdditionalItems(Either[Bool, Schema])
  MinItems(Int)
  MaxItems(Int)
  Contains(Schema)
  /// Specify how many times a schema matches a contains constraint. 
  MinContains(Int)
  MaxContains(Int)
  UniqueItems(Bool)

  // The compositional keywords
  AllOf(Array[Schema])
  AnyOf(Array[Schema])
  OneOf(Array[Schema])
  Not(Schema)

  // The conditionals keywords
  If(Schema)
  Then(Schema)
  Else(Schema)
} derive(Eq, Show)

///|
pub(all) type! SchemaParseError {
  InvalidSchema
} derive(Show)

///|
struct ErrorData {
  /// The stack of validing schema properties
  stack : Array[String]
  expected : Keyword
  received : Json?
} derive(Show)

///|
pub(all) enum JsonPointer {
  AbsolutePointer(id~ : String, Array[String])
  RelativePointer(Array[String])
} derive(Eq)

///|
pub(all) type! JsonError {
  KeyNotFound(path~ : JsonPointer, key~ : String, src~ : Json, Json)
  InvalidPath(src~ : String)
} derive(Show)

// TODO: Reimplement
// struct ValidationErrorData {
//  instance_path: JsonPath
//  schema_path: JsonPath
//  keyword: Keyword
//
// } derive(Show)

///|
pub(all) type ValidateError ErrorData derive(Show)
