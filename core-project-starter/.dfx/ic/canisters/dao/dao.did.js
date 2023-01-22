export const idlFactory = ({ IDL }) => {
  const List = IDL.Rec();
  const Account = IDL.Record({
    'owner' : IDL.Principal,
    'subaccount' : IDL.Opt(IDL.Vec(IDL.Nat8)),
  });
  const Tokens = IDL.Record({ 'amount' : IDL.Nat });
  List.fill(IDL.Opt(IDL.Tuple(IDL.Principal, List)));
  const ProposalState = IDL.Variant({
    'open' : IDL.Null,
    'rejected' : IDL.Null,
    'passed' : IDL.Null,
  });
  const Proposal = IDL.Record({
    'id' : IDL.Nat,
    'votes_no' : Tokens,
    'voters' : List,
    'state' : ProposalState,
    'proposer' : IDL.Principal,
    'votes_yes' : Tokens,
    'payload' : IDL.Text,
  });
  const Result_1 = IDL.Variant({ 'ok' : Proposal, 'err' : IDL.Text });
  const Result = IDL.Variant({ 'ok' : IDL.Text, 'err' : IDL.Text });
  return IDL.Service({
    'balance' : IDL.Func([Account], [IDL.Nat], []),
    'get_all_proposals' : IDL.Func(
        [],
        [IDL.Vec(IDL.Tuple(IDL.Nat, Proposal))],
        ['query'],
      ),
    'get_proposal' : IDL.Func([IDL.Nat], [IDL.Opt(Proposal)], ['query']),
    'submit_proposal' : IDL.Func([IDL.Text], [Result_1], []),
    'vote' : IDL.Func([IDL.Nat, IDL.Bool], [Result], []),
  });
};
export const init = ({ IDL }) => { return []; };
