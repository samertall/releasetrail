package releasetrail

import (
	"strings"
	"testing"
)

func TestValidations(t *testing.T) {
	if !validText("ReleaseTrail Core", 3, 80) {
		t.Fatal("ordinary product titles should be accepted")
	}
	if validText("Bad | injected", 3, 80) {
		t.Fatal("markdown table injection must be rejected")
	}
	if validText("<script>", 3, 80) {
		t.Fatal("HTML must be rejected")
	}
	if validText("Line 1\nLine 2", 3, 80) {
		t.Fatal("multiline input must be rejected")
	}
	if !validVersion("v1.0.0-beta") {
		t.Fatal("semantic versions should be accepted")
	}
	if validVersion("v1.0.0<script>") {
		t.Fatal("invalid version characters must be rejected")
	}
	if !validEvidenceURL("https://github.com/samertall") {
		t.Fatal("HTTPS evidence should be accepted")
	}
	if validEvidenceURL("javascript:alert(1)") {
		t.Fatal("script protocol should be rejected")
	}
	if validEvidenceURL("http://example.com") {
		t.Fatal("plain HTTP should be rejected")
	}
	if validEvidenceURL("https://example.com/evil)markdown") {
		t.Fatal("markdown link injection should be rejected")
	}
}

func TestInitialRender(t *testing.T) {
	page := Render("")
	if !strings.Contains(page, "ReleaseTrail") {
		t.Fatal("homepage should render project name")
	}
	if !strings.Contains(page, "Latest releases") {
		t.Fatal("homepage should render release feed")
	}
	if !strings.Contains(Render("/999999"), "Release not found") {
		t.Fatal("unknown release should have a safe 404 state")
	}
}

// Native Gno tests explicitly cross the realm boundary to exercise
// persistent mutation and runtime-authenticated caller identity.
func TestPublishAndRetract(cur realm, t *testing.T) {
	id := Publish(cross(cur), "ReleaseTrail", "v1.0.0", "First public milestone registered with evidence", "https://github.com/samertall")
	if id < 1 {
		t.Fatalf("expected positive release ID, got %d", id)
	}
	record := Detail(id)
	if !strings.Contains(record, "First public milestone") {
		t.Fatal("published record should be retrievable")
	}
	if Count() < 1 {
		t.Fatal("count should grow after publishing")
	}
	result := Retract(cross(cur), id)
	if result != "release retracted, history retained" {
		t.Fatal("retraction should preserve historical record")
	}
	if !strings.Contains(Detail(id), "Retracted") {
		t.Fatal("retracted release should remain visible")
	}
}
