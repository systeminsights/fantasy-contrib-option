R = require 'ramda'
{Some, None} = require 'fantasy-options'
{Left, Right} = require 'fantasy-eithers'

# :: a -> Option a
#
# Lift a value into Option, if a is null/undefined returns None else Some
#
optional = (a) ->
  if R.isNil(a)
    None
  else
    Some(a)

# :: Option a -> Boolean
#
# Return whether the option is a None
#
isNone = (o) ->
  o.fold(R.always(false), R.always(true))

# Alias for isNone
isEmpty = isNone

# :: Option a -> Boolean
#
# Return whether the option is a Some
#
isSome = (o) ->
  o.fold(R.always(true), R.always(false))

# :: (a -> Boolean) -> Option a -> Boolean
exists = R.curry((p, o) ->
  o.fold(p, R.always(false)))

# :: (a -> Boolean) -> Option a -> Option a
filter = R.curry((p, o) ->
  o.chain((a) ->
    if p(a)
      Some(a)
    else
      None))

# :: (a -> ()) -> Option a -> ()
#
# Run the given side-effect on the optional value
#
foreach = R.curry((f, o) ->
  o.fold(f, R.always(undefined))
  undefined)

# :: a -> Option b -> Either a b
toRight = R.curry((a, o) ->
  o.fold(Right, -> Left(a)))

# :: b -> Option a -> Either a b
toLeft = R.curry((b, o) ->
  o.fold(Left, -> Right(b)))

# :: Option a -> [a]
#
# Convert an option to an Array
#
toArray = (o) ->
  o.fold(R.of, R.always([]))

module.exports = {
  optional,
  isNone,
  isEmpty,
  isSome,
  exists,
  filter,
  foreach,
  toRight,
  toLeft,
  toArray
}

