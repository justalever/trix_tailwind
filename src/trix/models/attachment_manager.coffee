import ManagedAttachment from "trix/models/managed_attachment"
import BasicObject from "trix/core/basic_object"

export default class AttachmentManager extends BasicObject
  constructor: (attachments = []) ->
    super(arguments...)
    @managedAttachments = {}
    @manageAttachment(attachment) for attachment in attachments

  getAttachments: ->
    attachment for id, attachment of @managedAttachments

  manageAttachment: (attachment) ->
    @managedAttachments[attachment.id] ?= new ManagedAttachment this, attachment

  attachmentIsManaged: (attachment) ->
    attachment.id of @managedAttachments

  requestRemovalOfAttachment: (attachment) ->
    if @attachmentIsManaged(attachment)
      @delegate?.attachmentManagerDidRequestRemovalOfAttachment?(attachment)

  unmanageAttachment: (attachment) ->
    managedAttachment = @managedAttachments[attachment.id]
    delete @managedAttachments[attachment.id]
    managedAttachment
