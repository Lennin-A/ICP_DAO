import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

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
export type Result = { 'ok' : string } |
  { 'err' : string };
export type Result_1 = { 'ok' : Proposal } |
  { 'err' : string };
export interface Tokens { 'amount' : bigint }
export interface _SERVICE {
  'get_all_proposals' : ActorMethod<[], Array<[bigint, Proposal]>>,
  'get_proposal' : ActorMethod<[bigint], [] | [Proposal]>,
  'submit_proposal' : ActorMethod<[ProposalPayload], Result_1>,
  'update_proposal' : ActorMethod<[bigint, Proposal], Result>,
  'vote' : ActorMethod<[bigint, boolean], Result>,
}
