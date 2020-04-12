// Copyright (c) 2019 Jason T. Lenz.  All rights reserved.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

package example_test

import (
        "git.lenzplace.org/lenzj/testcli"
        "testing"
)

func TestExample(t *testing.T) {
        testcli.RunTests(t, "./example.sh")
}
