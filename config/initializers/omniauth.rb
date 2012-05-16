Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '5zgijb9G1mtxKnhsTe1cvA', 'VLoxR3kyh3zBAASPCtFt2Qc3fN2M5xK8sUiVNa2w'
  provider :github, '5ab76ea234765e0857f4', '80e7e6359fb9906494cc613cbf497c7de222727f'
end