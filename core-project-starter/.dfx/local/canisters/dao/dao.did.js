export const idlFactory = ({ IDL }) => {
  const List = IDL.Rec();
  const Tokens = IDL.Record({ 'amount' : IDL.Nat });
  List.fill(IDL.Opt(IDL.Tuple(IDL.Principal, List)));
  const ProposalState = IDL.Variant({
    'open' : IDL.Null,
    'rejected' : IDL.Null,
    'passed' : IDL.Null,
  });
  const ProposalPayload = IDL.Record({
    'canister_id' : IDL.Principal,
    'message' : IDL.Text,
  });
  const Proposal = IDL.Record({
    'id' : IDL.Nat,
    'votes_no' : Tokens,
    'voters' : List,
    'state' : ProposalState,
    'proposer' : IDL.Principal,
    'votes_yes' : Tokens,
    'payload' : ProposalPayload,
  });
  const Result_1 = IDL.Variant({ 'ok' : Proposal, 'err' : IDL.Text });
  const Result = IDL.Variant({ 'ok' : IDL.Text, 'err' : IDL.Text });
  return IDL.Service({
    'get_all_proposals' : IDL.Func(
        [],
        [IDL.Vec(IDL.Tuple(IDL.Nat, Proposal))],
        ['query'],
      ),
    'get_proposal' : IDL.Func([IDL.Nat], [IDL.Opt(Proposal)], ['query']),
    'submit_proposal' : IDL.Func([ProposalPayload], [Result_1], []),
    'update_proposal' : IDL.Func([IDL.Nat, Proposal], [Result], []),
    'vote' : IDL.Func([IDL.Nat, IDL.Bool], [Result], []),
  });
};
export const init = ({ IDL }) => { return []; };
