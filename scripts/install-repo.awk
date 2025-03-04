# Copyright (C) 2022-2024 CachyOS team
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

BEGIN { err = 1 }
  {
    if ($0 == "[options]") {
      print;
      next;
    } else if ($0 == "[cachyos]") {
      if (set) {
        rm = 2;
      }
      set = 1;
    } else if ($0 == "Architecture = x86_64" || $0 == "Architecture = x86_64 x86_64_v3" || $0 == "Architecture = x86_64 x86_64_v3 x86_64_v4") {
      print "Architecture = auto";
      next;
    }

    if (rm) {
      rm--;
      next;
    }
  }

  /^\[[^ \[\]]+\]/ {
    if (!set) {
        print "[cachyos]";
        print "Include = /etc/pacman.d/cachyos-mirrorlist";
        print "";
        set = 1;
        err = 0;
    }
  }
END {exit err}
1

# vim:set sw=2 sts=2 et:
