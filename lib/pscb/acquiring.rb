# frozen_string_literal: true

require 'openssl'
require 'pscb/acquiring/version' 
require 'pscb/acquiring/response'
require 'pscb/acquiring/request' 
require 'pscb/acquiring/command_parameters_convertor'
require 'pscb/acquiring/command_response_decorator'
require 'pscb/acquiring/client'
require 'pscb/acquiring/abstract_checksum_validator'
require 'pscb/acquiring/symmetric_key_checksum_validator'
require 'pscb/acquiring/asymmetric_key_checksum_validator'

module Pscb
  module Acquiring
    # Order statuses according to https://docs.pscb.ru/oos/index.html#obshaya-informaciya-spravochniki-statusy-platezhej
    ORDER_NEW        = 'new'        #
    ORDER_NOT_PAID   = 'sent'       # order is registered but not paid
    ORDER_PAID       = 'end'        #order paid, final status
    ORDER_HOLDED     = 'hold'       # pre-auth amount is holded (for 2-step payments)
    ORDER_ERROR      = 'err'        # Платёж не был оплачен вследствие ошибки (описание ошибки содержится в истории платежа).
    ORDER_CANCELLED  = 'canceled'   # Платёж отменён Магазином. Для двухстадийных платежей – сумма платежа расхолдирована на карте Плательщика.
    ORDER_EXPANDED   = 'exp'        # order expanded
    ORDER_REFUNDED   = 'ref'        # transaction amount was refunded
    ORDER_UNDEFINED  = 'undef'      # Состояние платежа не определено (будет определено позднее).
    ORDER_REJECTED   = 'rej'        # Платёж отвергнут Платёжной системой и не может быть оплачен.
=begin
    OPERATION_SUCCEEDED = 1
    OPERATION_FAILED    = 0

    OPERATION_APPROVED  = 'approved'.freeze  # amount holded
    OPERATION_DEPOSITED = 'deposited'.freeze # operation finished
    OPERATION_REVERSED  = 'reversed'.freeze  # operation cancelled
    OPERATION_REFUNDED  = 'refunded'.freeze  # amount refunded
=end
  end
end

PSCB = Pscb