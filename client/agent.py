import numpy as np





class RandomAgent:
    def __init__(self):
        self.step = 0

    def getAction(self):
        '''samples actions in a round-robin manner'''
        self.step = (self.step + 1) % 4
        return 'up down left right'.split()[self.step]

    def observe(self, newState, reward, event):
        pass


class Agent:
    def __init__(self, numStates, state, gamma, lamb, algorithm, randomseed, alpha):
        '''
        numStates: Number of states in the MDP
        state: The current state
        gamma: Discount factor
        lamb: Lambda for SARSA agent
        '''
        algorithm,trace = algorithm.split()
        if algorithm == 'random':
            self.agent = RandomAgent()
        elif algorithm == 'ql':
            self.agent = QlearningAgent(numStates, state, gamma, randomseed, alpha)
        elif algorithm == 'sarsa':
            self.agent = SarsaAgent(numStates, state, gamma, lamb, trace, randomseed, alpha)

    def getAction(self):
        '''returns the action to perform'''
        return self.agent.getAction()

    def observe(self, newState, reward, event):
        '''
        event:
            'continue'   -> The episode continues
            'terminated' -> The episode was terminated prematurely
            'goal'       -> The agent successfully reached the goal state
        '''
        self.agent.observe(newState, reward, event)


class SarsaAgent:

    def __init__(self, numStates, state, gamma, lamb, trace, randomseed, alpha):
        self.numStates = numStates
        self.currState = state
        # write the extra variables here that you need
        self.Q = np.random.rand(numStates, 4)
        self.e = np.zeros((numStates, 4))
        self.alpha = alpha
        self.eps = 0.8
        self.cumulative=False
        if trace == 'accum':
            self.cumulative = True
       
        np.random.seed(randomseed)
        # choose a random initial action
        self.currAction = self.getAction(getold=False, getVal=False)
        self.gamma = gamma
        self.lamb = lamb
        self.randomseed = randomseed


    def getAction(self, state = None, getold = True, getVal=True):
    
        
        

        actions = {0: 'up', 1: 'down', 2:'left', 3:'right'}
        action = None
        if not getold :
            # epsilon greedy
            if not state:
                state = self.currState


            if np.random.uniform() > self.eps :
                self.currAction = np.random.randint(4)
            else:
                self.currAction = np.argmax(self.Q[state])
            
        action = self.currAction
        result = None
        #print("action ", action, "curraction", self.currAction)
        if getVal:
            result = actions[action]
        else:
            result = action

        return result


    def observe(self, newState, reward, event):
        # we have new state and reward
        # use epsil
        s = self.currState
        a = self.currAction
        s_ = newState
        a_ = self.getAction(state=s_, getold = False, getVal=False)
        delta = reward + self.gamma*(self.Q[s_][a_]) - self.Q[s][a]
        
        if self.cumulative:
            self.e[s][a] += 1
        else:
            self.e[s][a] = 1

        self.Q = self.Q + self.alpha*delta*self.e
        self.e = self.gamma*self.lamb*self.e
        
        self.currState = s_
        self.currAction = a_        
        
        # only proceed if event is continue
        if event != 'continue' :
            # reset variables its start of a new episode 
            self.e =  np.zeros((self.numStates, 4))
            self.currState = np.random.randint(self.numStates)
            self.currAction = self.getAction(getold=False, getVal=False)
            return
        




class QlearningAgent:

    def __init__(self, numStates, state, gamma, randomseed, alpha):
        self.numStates = numStates
        self.currState = state
        # write the extra variables here that you need
        self.Q = np.random.rand(numStates, 4)
        self.alpha = alpha
        self.eps = 0.8
        np.random.seed(randomseed)
        # choose a random initial action
        self.gamma = gamma
        self.actions = ['up','down','left','right']

    def getAction(self, getVal=True):
        
        
        
        if np.random.uniform() > self.eps :
            self.currAction = np.random.randint(4)
        else:
            self.currAction = np.argmax(self.Q[self.currState])
        
        action = self.currAction
        result = None
        #print("action ", action, "curraction", self.currAction)
        if getVal:
            result = self.actions[action]
        else:
            result = action

        return result


    def observe(self, newState, reward, event):
       
       
        s = self.currState
        s_ = newState
        a = self.currAction
        self.Q[s][a]+= self.alpha*( reward + self.gamma*np.amax(self.Q[s_]) - self.Q[s][a] )
        self.currState = s_
        
        if event != "continue":
            self.currState = np.random.randint(self.numStates)
            return  
