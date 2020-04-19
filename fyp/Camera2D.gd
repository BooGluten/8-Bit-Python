
void LateUpdate()
  {
   //define start and end of level. 
   //This will detach the camera from the player until it enters the range again

     if(player.transform.position.x > 0f && player.transform.position.x < 10f)
     {
         transform.position = new Vector3(player.transform.position.x, 0f, -10f);
     }
   }
}