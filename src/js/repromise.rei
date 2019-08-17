/* This file is part of Repromise, released under the MIT license. See
   LICENSE.md for details, or visit
   https://github.com/aantron/repromise/blob/master/LICENSE.md. */



type rejectable('a, 'e);
type never;

type promise('a) = rejectable('a, never);
type t('a) = promise('a);



let make: unit => (promise('a), 'a => unit);

let resolved: 'a => promise('a);

let andThen: ('a => promise('b), promise('a)) => promise('b);

let map: ('a => 'b, promise('a)) => promise('b);

let wait: ('a => unit, promise('a)) => unit;

let all: list(promise('a)) => promise(list('a));

let all2: (promise('a), promise('b)) => promise(('a, 'b));

let all3: (promise('a), promise('b), promise('c)) => promise(('a, 'b, 'c));

let all4:
  (promise('a), promise('b), promise('c), promise('d)) =>
    promise(('a, 'b, 'c, 'd));

let all5:
  (promise('a), promise('b), promise('c), promise('d), promise('e)) =>
    promise(('a, 'b, 'c, 'd, 'e));

let all6:
  (promise('a),
   promise('b),
   promise('c),
   promise('d),
   promise('e),
   promise('f)) =>
      promise(('a, 'b, 'c, 'd, 'e, 'f));

let arrayAll: array(promise('a)) => promise(array('a));

let race: list(promise('a)) => promise('a);



module Rejectable: {
  type t('a, 'e) = rejectable('a, 'e);

  let relax: promise('a) => rejectable('a, _);

  let make: unit => (rejectable('a, 'e), 'a => unit, 'e => unit);

  let resolved: 'a => rejectable('a, _);

  let rejected: 'e => rejectable(_, 'e);

  let andThen:
    ('a => rejectable('b, 'e), rejectable('a, 'e)) => rejectable('b, 'e);

  let map: ('a => 'b, rejectable('a, 'e)) => rejectable('b, 'e);

  let wait: ('a => unit, rejectable('a, _)) => unit;

  let catch:
    ('e => rejectable('a, 'e2), rejectable('a, 'e)) => rejectable('a, 'e2);

  let all: list(rejectable('a, 'e)) => rejectable(list('a), 'e);

  let race: list(rejectable('a, 'e)) => rejectable('a, 'e);

  let fromJsPromise: Js.Promise.t('a) => rejectable('a, Js.Promise.error);

  let toJsPromise: rejectable('a, _) => Js.Promise.t('a);
};



let onUnhandledException: ref(exn => unit);
