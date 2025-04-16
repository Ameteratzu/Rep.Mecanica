const API_URL = process.env.REACT_APP_API_URL;

export const getUsers = async () => {
  const res = await fetch(`${API_URL}/users/`);
  return res.json();
};
