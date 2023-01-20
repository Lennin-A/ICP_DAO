import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface Account {
  'owner' : Principal,
  'subaccount' : [] | [Uint8Array],
}
export type List = [] | [[Principal, List]];
export interface Proposal {
  'id' : bigint,
  'votes_no' : Tokens,
  'voters' : List,
  'state' : ProposalState,
  'proposer' : Principal,
  'votes_yes' : Tokens,
  'payload' : ProposalPayload,
}
export interface ProposalPayload {
  'canister_id' : Principal,
  'message' : string,
}
export type ProposalState = { 'open' : null } |
  { 'rejected' : null } |
  { 'passed' : null };
export interface Tokens { 'amount' : bigint }
export interface _SERVICE {
  'balance' : ActorMethod<[Account], bigint>,
  'get_all_proposals' : ActorMethod<[], Array<[bigint, Proposal]>>,
  'get_proposal' : ActorMethod<[bigint], [] | [Proposal]>,
  'submit_proposal' : ActorMethod<
    [ProposalPayload],
    { 'Ok' : Proposal } |
      { 'Err' : string }
  >,
  'vote' : ActorMethod<
    [bigint, boolean],
    { 'Ok' : [bigint, bigint] } |
      { 'Err' : string }
  >,
}
