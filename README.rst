===========
deform_pure
===========

The famous ``deform`` web form generation library requires usage of the
``bootstrap`` CSS framework, but can easily be adapted to other CSS frameworks.

``deform_pure`` changes deform's templates in order to work with
Yahoo's ``pure`` CSS library.

TODO LINKS

It also contains special widgets and functions for Deform.


Installation
============

Here is the preferred way of enabling ``deform_pure`` on your website.
If you are using the Pyramid web framework, at configuration time, do this::

    config.include('deform_pure')
    config.init_deform_pure()

Then in your HTML template include our CSS file:

.. code-block:: HTML

    <link rel="stylesheet" href="${request.static_path('deform_pure:static/deform_pure.css')}" />

This sets deform up for i18n (configuring a translator function and pointing
colander and deform locale directories) and gives its template loader the
correct directory hierarchy, so it will search for templates first in
deform_pure, then in deform.


Our bootstrap-compatible templates
==================================

Our alterations to the templates are in the "templates" subdirectory.

Here are the changes we've made:

* checkbox.pt: Allows you to pass a *text* argument to a Boolean schema, and
  the text appears on the right of the checkbox.
* form.pt: Squashes a bug where buttons would be rendered disabled.
* mapping_item: Show error messages *below* help text.
* password.pt: Supports *maxlength* and *placeholder* and
  automatically sets *required*.
* textarea.pt: Supports *maxlength* and *placeholder* and
  automatically sets *required*.
* textinput.pt: Supports *maxlength* and *placeholder* and
  automatically sets *required*. Also supports any HTML5 input type --
  for instance, when instantiating a ``TextInputWidget``,
  you can set ``type='email'``.

All this has been tested against deform_bootstrap 0.2.8.

CSS file
========

Take a look on static/deform_pure.css -- it has a few improvements
on bootstrap's CSS so it works better with deform. The file has comments.

Our new widgets
===============

* widgets.TagsWidget: Sets up a beautiful jQuery-Tags-Input which in
  turn comes from http://xoxco.com/projects/code/tagsinput/

Abstract base view
==================

If you use the *Pyramid* web framework, here is a great little abstract base
class for views that use deform: `BaseDeformView. Check it out!
<https://github.com/nandoflorestan/deform_pure/blob/master/deform_pure/pyramid/views.py>`_

Helper functions
================

button()
--------

Use this function in a Pyramid app to easily generate a Deform button with
translated title and optionally a bootstrap icon.

    from deform_pure.pyramid import button

lengthen()
----------

Forms containing all inputs with the same size are extremely boring to
look at. When the widths of the inputs vary, not only the user gets a
better idea of how much to type in them, but the screen looks much more
interesting and easier to scan visually.

The ``lengthen()`` function calculates input width based on the
maxlength (which can optionally be inferred from a SQLAlchemy model property).
Example usage::

    from deform_pure.helpers import lengthen
    import colander as c

    class ContactSchema(CSRFSchema):
        name = c.SchemaNode(c.Str(), title=_("Name"), missing=None,
            **lengthen(Contact.name))  # this is a model property

from_now_on()
-------------

This Colander validator only accepts a time in the future. Example::

    from deform_pure.schema import from_now_on
    import colander as c

    class PromotionSchema(CSRFSchema):
        scheduled = c.SchemaNode(c.DateTime(default_tzinfo=None),
            missing=c.null, title=_("Schedule"), validator=from_now_on)
        (...)

    sch = PromotionSchema().bind(request=self.request, now=datetime.utcnow())

Trilean
-------

A schema type that can represent true, false and null. Example::

    from deform_pure.schema import Trilean
    import colander as c
    import deform.widget as w

    class ContactSchema(CSRFSchema):
        (...)
        male = c.SchemaNode(Trilean(), title=_("Sex"), missing=None,
            widget=w.SelectWidget(values=[
                (c.null, _("- Choose -")),
                ('false', _("Female")),
                ('true', _("Male")),
        ]))


Contribute
==========

You can help development at
https://github.com/nandoflorestan/deform_pure
