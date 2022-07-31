------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUN-TIME COMPONENTS                         --
--                                                                          --
--                       A D A . E X C E P T I O N S                        --
--       (Version for No Exception Handlers/No_Exception_Propagation)       --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--          Copyright (C) 1992-2020, Free Software Foundation, Inc.         --
--                                                                          --
-- This specification is derived from the Ada Reference Manual for use with --
-- GNAT. The copyright notice above, and the license provisions that follow --
-- apply solely to the  contents of the part following the private keyword. --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

--  Version is for use when there are no handlers in the partition (i.e. either
--  of Restriction No_Exception_Handlers or No_Exception_Propagation is set).

with System;
with System.Parameters;
with System.Traceback_Entries;

package Ada.Exceptions is
   pragma Preelaborate;
   --  In accordance with Ada 2005 AI-362

   type Exception_Id is private;
   pragma Preelaborable_Initialization (Exception_Id);

   Null_Id : constant Exception_Id;

   type Exception_Occurrence is limited private;
   pragma Preelaborable_Initialization (Exception_Occurrence);

   type Exception_Occurrence_Access is access all Exception_Occurrence;

   procedure Raise_Exception (E : Exception_Id; Message : String := "");
   pragma No_Return (Raise_Exception);
   --  Unconditionally call __gnat_last_chance_handler.
   --  Note that the exception is still raised even if E is the null exception
   --  id. This is a deliberate simplification for this profile (the use of
   --  Raise_Exception with a null id is very rare in any case, and this way
   --  we avoid introducing Raise_Exception_Always and we also avoid the if
   --  test in Raise_Exception).

private
   package SP renames System.Parameters;

   Exception_Msg_Max_Length : constant := SP.Default_Exception_Msg_Max_Length;

   ------------------
   -- Exception_Id --
   ------------------

   type Exception_Id is access all System.Address;
   Null_Id : constant Exception_Id := null;

   pragma Inline_Always (Raise_Exception);

   --------------------------
   -- Exception_Occurrence --
   --------------------------

   package TBE renames System.Traceback_Entries;

   Max_Tracebacks : constant := 50;
   --  Maximum number of trace backs stored in exception occurrence

   subtype Tracebacks_Array is TBE.Tracebacks_Array (1 .. Max_Tracebacks);
   --  Traceback array stored in exception occurrence

   type Exception_Occurrence is record
      Id : Exception_Id := Null_Id;
      --  Exception_Identity for this exception occurrence

      Machine_Occurrence : System.Address;
      --  The underlying machine occurrence. For GCC, this corresponds to the
      --  _Unwind_Exception structure address.

      Msg_Length : Natural := 0;
      --  Length of message (zero = no message)

      Msg : String (1 .. Exception_Msg_Max_Length);
      --  Characters of message

      Exception_Raised : Boolean := False;
      --  Set to true to indicate that this exception occurrence has actually
      --  been raised. When an exception occurrence is first created, this is
      --  set to False, then when it is processed by Raise_Current_Exception,
      --  it is set to True. If Raise_Current_Exception is used to raise an
      --  exception for which this flag is already True, then it knows that
      --  it is dealing with the reraise case (which is useful to distinguish
      --  for exception tracing purposes).

      Pid : Natural := 0;
      --  Partition_Id for partition raising exception

      Num_Tracebacks : Natural range 0 .. Max_Tracebacks := 0;
      --  Number of traceback entries stored

      Tracebacks : Tracebacks_Array;
      --  Stored tracebacks (in Tracebacks (1 .. Num_Tracebacks))
   end record;

   function "=" (Left, Right : Exception_Occurrence) return Boolean
     is abstract;
   --  Don't allow comparison on exception occurrences, we should not need
   --  this, and it would not work right, because of the Msg and Tracebacks
   --  fields which have unused entries not copied by Save_Occurrence.

end Ada.Exceptions;
