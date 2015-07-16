type ro = Message.ro
type rw = Message.rw
open Message.BytesMessage
module CallContext = struct
  type t = {
    params  : ro Message.t;
    results : rw Message.t;
  }
end
(* Need to redefine this since rpc.capnp can't appear in its own runtime *)
module CapDescriptor = struct
  type export_id = Uint32.t
  type import_id = export_id
  type promised_answer = export_id
  type t = SenderHosted of export_id
         | SenderPromise of export_id
         | RecieverHosted of import_id
         | RecieverAnswer of promised_answer
end
module type Capability = sig
  type t
  val call :  t
           -> interface_id:Uint64.t
           -> method_id:int (* Uint16.t *)
           -> ctx:CallContext.t
           -> unit (* Eventually this should be a promise *)
  val get_descriptor : t -> CapDescriptor.t option
end
