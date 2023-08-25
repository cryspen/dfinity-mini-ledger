module Mini_ledger_core.Balances
#set-options "--fuel 0 --ifuel 1 --z3rlimit 15"
open Core

class t_BalancesStore (v_Self: Type) (v_AccountId: Type) = {
  get_balance:self -> accountid -> Core.Option.t_Option Mini_ledger_core.Tokens.t_Tokens;
  update:self -> accountid -> f -> (self & Core.Result.t_Result Mini_ledger_core.Tokens.t_Tokens e)
}

let impl
      (#accountid: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Hash.t_Hash accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __2: Core.Cmp.t_Eq accountid)
    : t_BalancesStore
      (Std.Collections.Hash.Map.t_HashMap accountid
          Mini_ledger_core.Tokens.t_Tokens
          Std.Collections.Hash.Map.t_RandomState) accountid =
  {
    get_balance
    =
    (fun
        (#accountid: Type)
        (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized accountid)
        (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Hash.t_Hash accountid)
        (#[FStar.Tactics.Typeclasses.tcresolve ()] __2: Core.Cmp.t_Eq accountid)
        (self:
          Std.Collections.Hash.Map.t_HashMap accountid
            Mini_ledger_core.Tokens.t_Tokens
            Std.Collections.Hash.Map.t_RandomState)
        (k: accountid)
        ->
        Std.Collections.Hash.Map.get_under_impl_2 self k);
    update
    =
    fun
      (#accountid: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Hash.t_Hash accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __2: Core.Cmp.t_Eq accountid)
      (self:
        Std.Collections.Hash.Map.t_HashMap accountid
          Mini_ledger_core.Tokens.t_Tokens
          Std.Collections.Hash.Map.t_RandomState)
      (k: accountid)
      (f: f)
      ->
      Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* self, output:(Std.Collections.Hash.Map.t_HashMap
              accountid Mini_ledger_core.Tokens.t_Tokens Std.Collections.Hash.Map.t_RandomState &
            Core.Result.t_Result Mini_ledger_core.Tokens.t_Tokens e) =
            match Std.Collections.Hash.Map.get_under_impl_2 self k with
            | Core.Option.Option_Some entry ->
              let* new_v:Mini_ledger_core.Tokens.t_Tokens =
                match
                  Core.Ops.Try_trait.Try.branch (Core.Ops.Function.Fn.call f
                        (Core.Option.Option_Some entry)
                      <:
                      _)
                with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist1:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (self,
                        (Core.Ops.Try_trait.FromResidual.from_residual residual
                          <:
                          Core.Result.t_Result Mini_ledger_core.Tokens.t_Tokens e))
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist1)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              Core.Ops.Control_flow.ControlFlow_Continue
              (let self:Std.Collections.Hash.Map.t_HashMap accountid
                  Mini_ledger_core.Tokens.t_Tokens
                  Std.Collections.Hash.Map.t_RandomState =
                  if new_v <>. Mini_ledger_core.Tokens.v_ZERO_under_impl
                  then
                    let tmp0, out:(Std.Collections.Hash.Map.t_HashMap accountid
                        Mini_ledger_core.Tokens.t_Tokens
                        Std.Collections.Hash.Map.t_RandomState &
                      Core.Option.t_Option Mini_ledger_core.Tokens.t_Tokens) =
                      Std.Collections.Hash.Map.insert_under_impl_2 self k new_v
                    in
                    let self:Std.Collections.Hash.Map.t_HashMap accountid
                      Mini_ledger_core.Tokens.t_Tokens
                      Std.Collections.Hash.Map.t_RandomState =
                      tmp0
                    in
                    let _:(Std.Collections.Hash.Map.t_HashMap accountid
                        Mini_ledger_core.Tokens.t_Tokens
                        Std.Collections.Hash.Map.t_RandomState &
                      Core.Option.t_Option Mini_ledger_core.Tokens.t_Tokens) =
                      out
                    in
                    self
                  else
                    let tmp0, out:(Std.Collections.Hash.Map.t_HashMap accountid
                        Mini_ledger_core.Tokens.t_Tokens
                        Std.Collections.Hash.Map.t_RandomState &
                      Core.Option.t_Option Mini_ledger_core.Tokens.t_Tokens) =
                      Std.Collections.Hash.Map.remove_under_impl_2 self k
                    in
                    let self:Std.Collections.Hash.Map.t_HashMap accountid
                      Mini_ledger_core.Tokens.t_Tokens
                      Std.Collections.Hash.Map.t_RandomState =
                      tmp0
                    in
                    let _:(Std.Collections.Hash.Map.t_HashMap accountid
                        Mini_ledger_core.Tokens.t_Tokens
                        Std.Collections.Hash.Map.t_RandomState &
                      Core.Option.t_Option Mini_ledger_core.Tokens.t_Tokens) =
                      out
                    in
                    self
                in
                self, Core.Result.Result_Ok new_v)
            | _ ->
              let* new_v:Mini_ledger_core.Tokens.t_Tokens =
                match
                  Core.Ops.Try_trait.Try.branch (Core.Ops.Function.Fn.call f Core.Option.Option_None
                      <:
                      _)
                with
                | Core.Ops.Control_flow.ControlFlow_Break residual ->
                  let* hoist2:Rust_primitives.Hax.t_Never =
                    Core.Ops.Control_flow.ControlFlow.v_Break (self,
                        (Core.Ops.Try_trait.FromResidual.from_residual residual
                          <:
                          Core.Result.t_Result Mini_ledger_core.Tokens.t_Tokens e))
                  in
                  Core.Ops.Control_flow.ControlFlow_Continue
                  (Rust_primitives.Hax.never_to_any hoist2)
                | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
                  Core.Ops.Control_flow.ControlFlow_Continue v_val
              in
              Core.Ops.Control_flow.ControlFlow_Continue
              (let self:Std.Collections.Hash.Map.t_HashMap accountid
                  Mini_ledger_core.Tokens.t_Tokens
                  Std.Collections.Hash.Map.t_RandomState =
                  if new_v <>. Mini_ledger_core.Tokens.v_ZERO_under_impl
                  then
                    let tmp0, out:(Std.Collections.Hash.Map.t_HashMap accountid
                        Mini_ledger_core.Tokens.t_Tokens
                        Std.Collections.Hash.Map.t_RandomState &
                      Core.Option.t_Option Mini_ledger_core.Tokens.t_Tokens) =
                      Std.Collections.Hash.Map.insert_under_impl_2 self k new_v
                    in
                    let self:Std.Collections.Hash.Map.t_HashMap accountid
                      Mini_ledger_core.Tokens.t_Tokens
                      Std.Collections.Hash.Map.t_RandomState =
                      tmp0
                    in
                    let _:(Std.Collections.Hash.Map.t_HashMap accountid
                        Mini_ledger_core.Tokens.t_Tokens
                        Std.Collections.Hash.Map.t_RandomState &
                      Core.Option.t_Option Mini_ledger_core.Tokens.t_Tokens) =
                      out
                    in
                    self
                  else self
                in
                self, Core.Result.Result_Ok new_v)
          in
          Core.Ops.Control_flow.ControlFlow_Continue (self, output))
  }

type t_BalanceError =
  | BalanceError_InsufficientFunds { f_balance:Mini_ledger_core.Tokens.t_Tokens }: t_BalanceError

type t_Balances = {
  f_store:s;
  f_token_pool:Mini_ledger_core.Tokens.t_Tokens;
  f__marker:Core.Marker.t_PhantomData accountid
}

let v___: Prims.unit = ()

let v___1: Prims.unit = ()

let impl
      (#accountid #s: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __2: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __3: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __4: t_BalancesStore s accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __5: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __6: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __7: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __8: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __9: t_BalancesStore s accountid)
    : Core.Default.t_Default (t_Balances accountid s) =
  {
    default
    =
    fun
      (#accountid: Type)
      (#s: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __2: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __3: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __4: t_BalancesStore s accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __5: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __6: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __7: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __8: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __9: t_BalancesStore s accountid)
      ->
      new_under_impl_2
  }

let new_under_impl_2
      (#accountid #s: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __2: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __3: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __4: t_BalancesStore s accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __5: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __6: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __7: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __8: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __9: t_BalancesStore s accountid)
    : t_Balances accountid s =
  {
    Mini_ledger_core.Balances.Balances.f_store = Core.Default.Default.v_default;
    Mini_ledger_core.Balances.Balances.f_token_pool = Mini_ledger_core.Tokens.v_MAX_under_impl;
    Mini_ledger_core.Balances.Balances.f__marker = Core.Marker.PhantomData
  }

let transfer_under_impl_2
      (#accountid #s: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __2: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __3: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __4: t_BalancesStore s accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __5: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __6: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __7: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __8: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __9: t_BalancesStore s accountid)
      (self: t_Balances accountid s)
      (from to: accountid)
      (amount fee: Mini_ledger_core.Tokens.t_Tokens)
    : (t_Balances accountid s & Core.Result.t_Result Prims.unit t_BalanceError) =
  Rust_primitives.Hax.Control_flow_monad.Mexception.run (let* debit_amount:Mini_ledger_core.Tokens.t_Tokens
      =
        match
          Core.Ops.Try_trait.Try.branch (Core.Result.map_err_under_impl (amount +. fee <: _)
                (fun _ ->
                    let balance:Mini_ledger_core.Tokens.t_Tokens =
                      account_balance_under_impl_2 self from
                    in
                    BalanceError_InsufficientFunds
                    ({
                        Mini_ledger_core.Balances.BalanceError.InsufficientFunds.f_balance = balance
                      }))
              <:
              Core.Result.t_Result Mini_ledger_core.Tokens.t_Tokens t_BalanceError)
        with
        | Core.Ops.Control_flow.ControlFlow_Break residual ->
          let* hoist3:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (self,
                (Core.Ops.Try_trait.FromResidual.from_residual residual
                  <:
                  Core.Result.t_Result Prims.unit t_BalanceError))
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist3)
        | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
          Core.Ops.Control_flow.ControlFlow_Continue v_val
      in
      let tmp0, out:(t_Balances accountid s &
        Core.Result.t_Result Mini_ledger_core.Tokens.t_Tokens t_BalanceError) =
        debit_under_impl_2 self from debit_amount
      in
      let self:t_Balances accountid s = tmp0 in
      let hoist5:(t_Balances accountid s &
        Core.Result.t_Result Mini_ledger_core.Tokens.t_Tokens t_BalanceError) =
        out
      in
      let hoist6:Core.Ops.Control_flow.t_ControlFlow _ _ = Core.Ops.Try_trait.Try.branch hoist5 in
      let* _:Mini_ledger_core.Tokens.t_Tokens =
        match hoist6 with
        | Core.Ops.Control_flow.ControlFlow_Break residual ->
          let* hoist4:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (self,
                (Core.Ops.Try_trait.FromResidual.from_residual residual
                  <:
                  Core.Result.t_Result Prims.unit t_BalanceError))
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist4)
        | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
          Core.Ops.Control_flow.ControlFlow_Continue v_val
      in
      Core.Ops.Control_flow.ControlFlow_Continue
      (let self:t_Balances accountid s = credit_under_impl_2 self to amount in
        let self:t_Balances accountid s =
          {
            self with
            Mini_ledger_core.Balances.Balances.f_token_pool
            =
            Core.Ops.Arith.AddAssign.add_assign self.Mini_ledger_core.Balances.Balances.f_token_pool
              fee
          }
        in
        let output:Core.Result.t_Result Prims.unit t_BalanceError = Core.Result.Result_Ok () in
        self, output))

let burn_under_impl_2
      (#accountid #s: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __2: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __3: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __4: t_BalancesStore s accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __5: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __6: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __7: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __8: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __9: t_BalancesStore s accountid)
      (self: t_Balances accountid s)
      (from: accountid)
      (amount: Mini_ledger_core.Tokens.t_Tokens)
    : (t_Balances accountid s & Core.Result.t_Result Prims.unit t_BalanceError) =
  Rust_primitives.Hax.Control_flow_monad.Mexception.run (let tmp0, out:(t_Balances accountid s &
        Core.Result.t_Result Mini_ledger_core.Tokens.t_Tokens t_BalanceError) =
        debit_under_impl_2 self from amount
      in
      let self:t_Balances accountid s = tmp0 in
      let hoist8:(t_Balances accountid s &
        Core.Result.t_Result Mini_ledger_core.Tokens.t_Tokens t_BalanceError) =
        out
      in
      let hoist9:Core.Ops.Control_flow.t_ControlFlow _ _ = Core.Ops.Try_trait.Try.branch hoist8 in
      let* _:Mini_ledger_core.Tokens.t_Tokens =
        match hoist9 with
        | Core.Ops.Control_flow.ControlFlow_Break residual ->
          let* hoist7:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (self,
                (Core.Ops.Try_trait.FromResidual.from_residual residual
                  <:
                  Core.Result.t_Result Prims.unit t_BalanceError))
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist7)
        | Core.Ops.Control_flow.ControlFlow_Continue v_val ->
          Core.Ops.Control_flow.ControlFlow_Continue v_val
      in
      Core.Ops.Control_flow.ControlFlow_Continue
      (let self:t_Balances accountid s =
          {
            self with
            Mini_ledger_core.Balances.Balances.f_token_pool
            =
            Core.Ops.Arith.AddAssign.add_assign self.Mini_ledger_core.Balances.Balances.f_token_pool
              amount
          }
        in
        let output:Core.Result.t_Result Prims.unit t_BalanceError = Core.Result.Result_Ok () in
        self, output))

let mint_under_impl_2
      (#accountid #s: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __2: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __3: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __4: t_BalancesStore s accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __5: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __6: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __7: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __8: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __9: t_BalancesStore s accountid)
      (self: t_Balances accountid s)
      (to: accountid)
      (amount: Mini_ledger_core.Tokens.t_Tokens)
    : (t_Balances accountid s & Core.Result.t_Result Prims.unit t_BalanceError) =
  let self:t_Balances accountid s =
    {
      self with
      Mini_ledger_core.Balances.Balances.f_token_pool
      =
      Core.Result.expect_under_impl (self.Mini_ledger_core.Balances.Balances.f_token_pool -. amount
          <:
          _)
        "total token supply exceeded"
    }
  in
  let self:t_Balances accountid s = credit_under_impl_2 self to amount in
  let output:Core.Result.t_Result Prims.unit t_BalanceError = Core.Result.Result_Ok () in
  self, output

let debit_under_impl_2
      (#accountid #s: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __2: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __3: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __4: t_BalancesStore s accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __5: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __6: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __7: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __8: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __9: t_BalancesStore s accountid)
      (self: t_Balances accountid s)
      (from: accountid)
      (amount: Mini_ledger_core.Tokens.t_Tokens)
    : (t_Balances accountid s & Core.Result.t_Result Mini_ledger_core.Tokens.t_Tokens t_BalanceError
    ) =
  let hoist12: Core.Option.t_Option Mini_ledger_core.Tokens.t_Tokens
    -> Core.Result.t_Result Mini_ledger_core.Tokens.t_Tokens t_BalanceError =
    fun prev ->
      let* balance:Mini_ledger_core.Tokens.t_Tokens =
        match prev with
        | Core.Option.Option_Some x -> Core.Ops.Control_flow.ControlFlow_Continue x
        | Core.Option.Option_None  ->
          let* hoist10:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (self,
                Core.Result.Result_Err
                (BalanceError_InsufficientFunds
                  ({
                      Mini_ledger_core.Balances.BalanceError.InsufficientFunds.f_balance
                      =
                      Mini_ledger_core.Tokens.v_ZERO_under_impl
                    })))
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist10)
      in
      let* _:Prims.unit =
        if balance <. amount
        then
          let* hoist11:Rust_primitives.Hax.t_Never =
            Core.Ops.Control_flow.ControlFlow.v_Break (self,
                Core.Result.Result_Err
                (BalanceError_InsufficientFunds
                  ({ Mini_ledger_core.Balances.BalanceError.InsufficientFunds.f_balance = balance })
                ))
          in
          Core.Ops.Control_flow.ControlFlow_Continue (Rust_primitives.Hax.never_to_any hoist11)
        else Core.Ops.Control_flow.ControlFlow_Continue ()
      in
      Core.Ops.Control_flow.ControlFlow_Continue
      (let balance:Mini_ledger_core.Tokens.t_Tokens =
          Core.Ops.Arith.SubAssign.sub_assign balance amount
        in
        Core.Result.Result_Ok balance)
  in
  let tmp0, out:(s & Core.Result.t_Result Mini_ledger_core.Tokens.t_Tokens t_BalanceError) =
    Mini_ledger_core.Balances.BalancesStore.update self.Mini_ledger_core.Balances.Balances.f_store
      (Core.Clone.Clone.clone from <: accountid)
      hoist12
  in
  let self:t_Balances accountid s =
    { self with Mini_ledger_core.Balances.Balances.f_store = tmp0 }
  in
  let output:(s & Core.Result.t_Result Mini_ledger_core.Tokens.t_Tokens t_BalanceError) = out in
  self, output

let credit_under_impl_2
      (#accountid #s: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __2: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __3: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __4: t_BalancesStore s accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __5: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __6: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __7: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __8: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __9: t_BalancesStore s accountid)
      (self: t_Balances accountid s)
      (to: accountid)
      (amount: Mini_ledger_core.Tokens.t_Tokens)
    : t_Balances accountid s =
  let tmp0, out:(s & Core.Result.t_Result Mini_ledger_core.Tokens.t_Tokens Core.Convert.t_Infallible
  ) =
    Mini_ledger_core.Balances.BalancesStore.update self.Mini_ledger_core.Balances.Balances.f_store
      (Core.Clone.Clone.clone to <: accountid)
      (fun prev ->
          Core.Result.Result_Ok
          (Core.Result.expect_under_impl (amount +.
                (Core.Option.unwrap_or_under_impl prev Mini_ledger_core.Tokens.v_ZERO_under_impl
                  <:
                  Mini_ledger_core.Tokens.t_Tokens)
                <:
                _)
              "bug: overflow in credit"
            <:
            Mini_ledger_core.Tokens.t_Tokens))
  in
  let self:t_Balances accountid s =
    { self with Mini_ledger_core.Balances.Balances.f_store = tmp0 }
  in
  let hoist13:(s & Core.Result.t_Result Mini_ledger_core.Tokens.t_Tokens Core.Convert.t_Infallible)
  =
    out
  in
  let _:Mini_ledger_core.Tokens.t_Tokens = Core.Result.unwrap_under_impl hoist13 in
  self

let account_balance_under_impl_2
      (#accountid #s: Type)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __0: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __1: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __2: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __3: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __4: t_BalancesStore s accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __5: Core.Marker.t_Sized accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __6: Core.Marker.t_Sized s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __7: Core.Clone.t_Clone accountid)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __8: Core.Default.t_Default s)
      (#[FStar.Tactics.Typeclasses.tcresolve ()] __9: t_BalancesStore s accountid)
      (self: t_Balances accountid s)
      (account: accountid)
    : Mini_ledger_core.Tokens.t_Tokens =
  Core.Option.unwrap_or_under_impl (Core.Option.cloned_under_impl_2 (Mini_ledger_core.Balances.BalancesStore.get_balance
            self.Mini_ledger_core.Balances.Balances.f_store
            account
          <:
          Core.Option.t_Option Mini_ledger_core.Tokens.t_Tokens)
      <:
      Core.Option.t_Option Mini_ledger_core.Tokens.t_Tokens)
    Mini_ledger_core.Tokens.v_ZERO_under_impl