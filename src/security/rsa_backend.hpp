/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019–present OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#pragma once

#ifndef USE_PRECOMPILED_HEADERS
	#include <memory>
	#include <stdexcept>
	#include <string>
#endif

class Logger;

// Thrown by RsaBackend::loadPEM when the file parses as a valid RSA private
// key of the WRONG size, as opposed to being missing/corrupt/not-RSA. This
// case must never be treated the same as "no key configured yet" - the
// operator deliberately supplied a real key, and silently discarding it for
// the public default (see key.pem / SECURITY_AUDIT.md 3.3.1) is exactly the
// fail-open trap documented in SECURITY_AUDIT.md 3.3.2.
class RsaKeySizeMismatch final : public std::runtime_error {
public:
	using std::runtime_error::runtime_error;
};

class RsaBackend {
public:
	virtual ~RsaBackend() = default;
	virtual bool loadPEM(const std::string &filename) = 0;
	virtual void setKey(const char* pString, const char* qString, int base) = 0;
	virtual void decrypt(char* msg) const = 0;
};

std::unique_ptr<RsaBackend> createMbedTlsRsaBackend(Logger &logger);
