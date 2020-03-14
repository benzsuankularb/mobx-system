import 'package:mobx/mobx.dart' as mobx;
export 'package:mobx/mobx.dart' show reaction, autorun, when, asyncWhen;

mobx.ReactionDisposer reactionWhen(
    bool Function(mobx.Reaction) predicate, void Function() effect,
    {String name,
    mobx.ReactiveContext context,
    int timeout,
    void Function(Object, mobx.Reaction) onError}) {
  return mobx.reaction<bool>(
    (reaction) => predicate(reaction),
    (condition) {
      if (condition) {
        effect();
      }
    },
    name: name,
    context: context,
    onError: onError,
  );
}
