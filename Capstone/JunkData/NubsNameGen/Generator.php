<?php
use Cinam\Randomizer\Randomizer;

/**
 * Defines an alliterative name generator.
 */
class StuffGenerator
{
    /** @type array The definition of the potential adjectives. */
    protected $_adjectives;

    /** @type array The definition of the potential nouns. */
    protected $_nouns;
	
	/** @type array The definition of the potential cities. */
    protected $_cities;
	
	/** @type array The definition of the potential state codes. */
    protected $_statecodes;
	
	/** @type array The definition of the potential state codes. */
    protected $_colors;
	
	/** @type array The definition of the potential bike brands. */
    protected $_bikeBrands;
	
	/** @type array The definition of the potential interesting nonsense. */
    protected $_interNons;

    /** @type Cinam\Randomizer\Randomizer The random number generator. */
    protected $_randomizer;

    /**
     * Initializes the Generator with the default word lists.
     *
     * @api
     * @param \Cinam\Randomizer\Randomizer $randomizer The random number generator.
     */
    public function __construct(Randomizer $randomizer = null)
    {
        $this->_randomizer = $randomizer;
        $this->_adjectives = file(__DIR__ . '/adjectives.txt', FILE_IGNORE_NEW_LINES);
        $this->_nouns = file(__DIR__ . '/nouns.txt', FILE_IGNORE_NEW_LINES);
        $this->_cities = file(__DIR__ . '/cities.txt', FILE_IGNORE_NEW_LINES);
        $this->_statecodes = file(__DIR__ . '/statecodes.txt', FILE_IGNORE_NEW_LINES);
        $this->_colors = file(__DIR__ . '/colors.txt', FILE_IGNORE_NEW_LINES);
        $this->_bikeBrands = file(__DIR__ . '/bikeBrands.txt', FILE_IGNORE_NEW_LINES);
        $this->_interNons = file(__DIR__ . '/video_game_names.txt', FILE_IGNORE_NEW_LINES);
    }
	
	/**
     * Gets a randomly generated adjective.
     *
     * @return string A random adjective.
     */
    public function getAdjective()
    {
        return $this->_getRandomWord($this->_adjectives);
    }
	
	/**
     * Gets a randomly generated noun.
     *
     * @return string A random noun.
     */
    public function getNoun()
    {
        return $this->_getRandomWord($this->_nouns);
    }
	
	/**
     * Gets a randomly generated name.
     *
     * @return string A random name.
     */
    public function getName()
    {
        $adjective = $this->_getRandomWord($this->_adjectives);
        $noun = $this->_getRandomWord($this->_nouns);

        return ucwords("{$adjective} {$noun}");
    }

    /**
     * Gets a randomly generated alliterative name.
     *
     * @return string A random alliterative name.
     */
    public function getAlliterativeName()
    {
        $adjective = $this->_getRandomWord($this->_adjectives);
        $noun = $this->_getRandomWord($this->_nouns, $adjective[0]);

        return ucwords("{$adjective} {$noun}");
    }
	
	/**
     * Gets a randomly generated city.
     *
     * @return string A random city.
     */
    public function getCity()
    {
        return $this->_getRandomWord($this->_cities);
    }
	
	/**
     * Gets a randomly generated state code.
     *
     * @return string A random state code.
     */
    public function getStateCode()
    {
        return $this->_getRandomWord($this->_statecodes);
    }
	
	/**
     * Gets a randomly generated color.
     *
     * @return string A random color.
     */
    public function getColor()
    {
        return $this->_getRandomWord($this->_colors);
    }
	
	/**
     * Gets a randomly generated bike brand.
     *
     * @return string A random bike brand.
     */
    public function getBikeBrand()
    {
        return $this->_getRandomWord($this->_bikeBrands);
    }
	
	/**
     * Gets randomly generated interesting nonsense.
     *
     * @return string Some random interesting nonsense.
     */
    public function getInterestingNonsense()
    {
        return $this->_getRandomWord($this->_interNons);
    }

    /**
     * Get a random word from the list of words, optionally filtering by starting letter.
     *
     * @param array $words An array of words to choose from.
     * @param string $startingLetter The desired starting letter of the word.
     * @return string The random word.
     */
    protected function _getRandomWord(array $words, $startingLetter = null)
    {
        $wordsToSearch = $startingLetter === null ? $words : preg_grep("/^{$startingLetter}/", $words);
        return $this->_randomizer ?  $this->_randomizer->getArrayValue($wordsToSearch) : $wordsToSearch[array_rand($wordsToSearch)];
    }
}
