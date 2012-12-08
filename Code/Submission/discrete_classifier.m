% discrete_classifier is the standadized interface between our code and our
% dear teachers and testers.
% VERSION Beta - Not yet tested by testers (featuring simple generative algorithm)
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   SMASHING MASHED POTATOES                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Antoine Lizée
% Octave Etard
% Nathalie Dupuy
% Saud Saldulkar
% Ortal Dayan
%
% Copyright Mashed Potatoes @ ICL, 05/03/2012


function [reaching_angles] = discrete_classifier(training_data, test_data)
    
  %% Customisation
  method='gauss';
  
  
  %% Initialisation
  % (Only selected neurons are supplied)
  act_training=extract_data(training_data); % Extract the data from the 2D structure into a 4D array for t=0..300ms
  act_test=extract_test_data(test_data);
    
  load('SelectedNeurons'); 
  %reaching_angles = zeros(length(test_data), 1);
  
  %% Training:  
  param=getparam(act_training, method);
  
  %% Test:
  reaching_angles=decode(act_test, param);
  
end

