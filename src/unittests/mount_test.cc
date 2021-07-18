/*
   Copyright 2013-2014 EditShare, 2013-2015 Skytechnology sp. z o.o.

   This file is part of LizardFS.

   LizardFS is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, version 3.

   LizardFS is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with LizardFS. If not, see <http://www.gnu.org/licenses/>.
 */

#include <memory>
#include <gtest/gtest.h>
#include "mount/special_inode.h"

namespace LizardClient {
struct MockFileInfo : public FileInfo {
};
}

TEST(MountUnitTests, TestSpecialFileHelloReturnsExpectedResult) {
	LizardClient::MockFileInfo fi;
	fi.fh = 80;
	char payload[] = "Hello World!\n";
	size_t size = strlen(payload);
	std::vector<uint8_t> expectedResult(payload, payload + size);

	auto context1 = std::unique_ptr<LizardClient::Context>(new LizardClient::Context(12, 13, 14, 16));

	auto readReply = special_read(InodeBaldor::inode_, *context1, 80, 0, &fi, 0);

	EXPECT_EQ(expectedResult, readReply);
}