vico-fill-in-the-blanks.tmbundle
================================

This bundle is meant to fill in any blanks between vico and vim that I feel a
need for. Put differently, when I run into a feature that I use in vim that
vico doesn't have and I see it's implementable using vico's Nu scripting, I try
to throw it in here.

Things Implemented
------------------

* zz/zt/zb -- zz centers the scroll on the current line, zt puts it at the top
  of the screen, zb at the bottom.
  
  This implementation constrains the scroll by the top and bottom of the scroll
  document. Usually vim lets you scroll past the end of the document to properly
  align the line in the center, but doing that here messes with repeated
  invocations of zz because I'm pretty sure scrolling past the end of a view is
  something Cocoa isn't a fan of.

  zt and zb are both constrained, as well. All of these commands will scroll as
  far in the necessary direction as possible, so they'll get as close to your
  requested position as possible without scrolling off the end of the view.

License
-------

This bundle is provided under the terms of the MIT License. See the LICENSE file in
this same directory.

Author
------

This bundle is copyright me, Antonio Salazar Cardozo, and licensed under the
terms of the MIT license. No warranties are made, express or implied. See the
LICENSE file in this same directory for more details.

I have a rather sporadically updated blog at http://shadowfiend.posterous.com/

I am the Chief Software Engineer at OpenStudy (http://openstudy.com/); we're
working on making the world one big study group.
