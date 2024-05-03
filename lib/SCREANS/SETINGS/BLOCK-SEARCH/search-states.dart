abstract class SearchStates {}

class Search_Initial_State extends SearchStates {}


class Search_loading_state extends SearchStates {}
class Search_success_state extends SearchStates {}
class Search_error_state extends SearchStates {}

class Get_Details_loading_state extends SearchStates {}
class Get_Details_success_state extends SearchStates {}
class Get_Details_error_state extends SearchStates {}