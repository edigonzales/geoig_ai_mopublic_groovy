/*
 * This Spock specification was auto generated by running 'gradle init --type groovy-library'
 * by 'stefan' at '7/23/15 7:51 PM' with Gradle 2.5
 *
 * @author stefan, @date 7/23/15 7:51 PM
 */

import spock.lang.Specification

class LibraryTest extends Specification{
    def "someLibraryMethod returns true"() {
        setup:
        Library lib = new Library()
        when:
        def result = lib.someLibraryMethod()
        then:
        result == true
    }
}
