
!!!!!!!!!!!!!!!!!_______ 		HEADER COMMENTS.             ___________!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
!!!!!!!!!!!!!!!!!!!!! THE MODULE ENCAPSULATED THE FOLLOWING INFORMATION: ..... !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!! _________________________________________________________!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
module parsing



  USE OpenCMISS
  USE OpenCMISS_Iron

  integer                                      :: i,filestat,n,stat,pos1,pos2,dummy  						!! These variables are used as indices in the parsing algorithm...

  character(len=100)                           :: rdline                             						!! This variable stores the lines Read  statement. 

  character(len=100),allocatable               :: EquationsSet_arg1(:,:),EquationsSet_arg2(:,:),EquationsSet_arg3(:,:), &       !! These data structures contain the input arguments given by...  
						  &EquationsSet_arg4(:,:), EquationsSet_parsing(:)			        !! the user related to the EquationsSet  
                                                                                
 

  character(len=100),allocatable               :: Problem_arg1(:,:),Problem_arg2(:,:),Problem_arg3(:,:), &                      !! These data structures contain the input arguments given by...  
							  &Problem_arg4(:,:), Problem_parsing(:)				!!  the user related to Problem
                                                  


  character(len=100),allocatable               :: MaterialField_arg1(:,:),MaterialField_arg2(:,:),MaterialField_arg3(:,:), &    !! These data structures contain the input arguments given by...  
                                                  &MaterialField_parsing(:)                                                     !!  the user related to MaterialField.

  character(len=100),allocatable               :: Mesh_parsing(:),Mesh_arg1(:,:),Mesh_arg2(:,:),Mesh_arg3(:,:),Mesh_arg4(:,:),& !! These data structures contain the input arguments given by... 
                                                  &Mesh_arg5(:,:) 					 			!! related to the mesh. 

  character(len=100),allocatable               :: BC_parsing(:),BC_arg1(:,:),BC_arg2(:,:),BC_arg3(:,:),BC_arg4(:,:),&           !! related to the BoundaryCOndition.
                                                  &BC_arg5(:,:)


  character(len=100),allocatable               :: Solvers_arguments(:,:), Solvers_parsing(:)					!! related to the Solver.

  character(len=100),allocatable               :: Basis_arguments(:,:), Basis_parsing(:)			  		!! related to the BoundaryCOndition.


  character(len=100),allocatable               :: Region_arguments(:,:), Region_parsing(:)					!! related to the Region.

  character(len=100),allocatable               :: CoordinateSystem_arguments(:,:), CoordinateSystem_parsing(:)		 	!! related to the CoordinateSystem.

  character(len=100),allocatable               :: ControlLoop_arguments(:,:), ControlLoop_parsing(:)				!! related to the ControlLOOP.

  character(len=100),allocatable               :: DependentField_arguments(:,:), DependentField_parsing(:) 			!! related to the Dependent FIeld.

  character(len=100),allocatable               :: FiberField_arg1(:,:), FiberField_arg2(:,:),FiberField_parsing(:)		!! related to the FiberFIeld.

  character(len=100),allocatable               :: PressureBasis_parsing(:), PressureBasis_arguments(:,:)			!! related to the PressureBasis.

  character(len=100),allocatable               :: Output_parsing(:), Output_arguments(:,:)					!! related to the OUtput.

  character(len=100),allocatable               :: Field_parsing(:), Field_arg1(:,:),Field_arg2(:,:), Field_arg3(:,:)		!! related to the Field.

  contains

  !!!!!!!!!!!!!!!!!!!!!!!! FOLLOWING SUBROUTINE PARSE "FIELD  (GRAVITATIONAL FIELD etc. ) BLOCK" IN INPUT FILE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
  !!!!!!!!!!!!!!!!!!!!!!!   NOTE THAT  THE REMAINING SUBROUTINES ALSO HAVE THE SAME STRUCTURE, THEREFORE .... !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!!!!!!!!!!!!!!!!!!!!!!    FOR EASE ONLY THE FOLLOWING SUBROUTINE IS COMMENTED. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  subroutine   Field_parsing_subroutine(string1,Field_arg1,Field_arg2,Field_arg3,rdline)
                                             

    integer                                            :: i,filestat,n,stat,k,pos1,pos2			!! These variables are used as indices in the parsing algorithm.
    character(len=100) , dimension(:,:),allocatable    :: Field_arg1,Field_arg2,Field_arg3		!! Arguments where the field related parameters are stored.
    character(len=100)                                 :: rdline,g
    character(len=100),   dimension(:)                 :: string1						!! THis is the data structure that contains the keywords,
		 											!! .... the algorithm looks for .
    


    if (trim(rdline)=="START_FIELD") then                                                                  !! Start of the Field block in the input file. 
    
       readline:do

          read(12,'(A)',iostat=filestat), rdline
          rdline =  strip_space(rdline)                                                                   !! remove leading and triling spaces from the string.
          call remove_character(rdline,"!")							        !! remove comments off a string.
									
          if (trim(rdline)=="END_FIELD") exit						 		!! Terminate as soon as the cursor hits this keyword.

          if (rdline.EQ.string1(1)) then                                                                  !! Storing input argument 1 of Field block.
             read(12,'(A)',iostat=filestat), rdline
             call skip_blank_lines(rdline)								!! This  ignores all the blank spaces.
             call remove_character(rdline,"!")
             rdline =  strip_space(rdline)
             Field_arg1(:,1) = rdline
          end if


          if (rdline.EQ.string1(2)) then								        !! Storing input argument 2 of Field block.
             read(12,'(A)',iostat=filestat), rdline
             call skip_blank_lines(rdline)
             call remove_character(rdline,"!")
             rdline =  strip_space(rdline)
             Field_arg2(:,1) = rdline
          end if

          if (rdline.EQ.string1(3)) then								 	!! Storing input argument 3 of Field block.
             read(12,'(A)',iostat=filestat), rdline						        
             call skip_blank_lines(rdline)
             call remove_character(rdline,"!")				
             rdline =  strip_space(rdline)
             call split_inline_argument(rdline,Field_arg3)						!! Argument 3 is supposed to be a vector, therefore this  subroutine is used to to store right
													    										
          end if												!! values in the data structure  data

      end do readline


    end if  												!! if (trim(rdline)=="START_FIELD")

  end subroutine Field_parsing_subroutine

  !!!!!!!!!!!!!!!!!!!!!!! FOLLOWING SUBROUTINE PARSE "BOUDARY CONDITIONS"  IN INPUT FILE. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!!!!!!!!!!!!!!!!!!!!!!! FOR COMMENTS PLEASE REFER TO THE "Field_parsing_subroutine."  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  subroutine   BC_parsing_subroutine(string1,boundary_conditions_arg1,boundary_conditions_arg2,boundary_conditions_arg3,&
                       & boundary_conditions_arg4, rdline,num_of_dirichelet)


    integer                                            :: i,filestat,n,stat,k,pos1,pos2,num_of_dirichelet
    character(len=100) , dimension(:,:),allocatable    :: boundary_conditions_arg1,boundary_conditions_arg2,&
                                                          &boundary_conditions_arg4,boundary_conditions_arg3
    character(len=100)                                 :: rdline,g
    character(len=100),   dimension(:)                 :: string1

 

    if (trim(rdline)=="START_BOUNDARY_CONDITIONS") then
      num_of_dirichelet= 0
      num_of_traction_neumann=0
      num_of_pressure_neumann=0

      readline: do

        read(12,'(A)'), rdline
        rdline =  strip_space(rdline)
        call remove_character(rdline,"!")
        if (trim(rdline)=="END_BOUNDARY_CONDITIONS") exit

          if (rdline.EQ.string1(1)) then
             read(12,'(A)',iostat=filestat), rdline
             call skip_blank_lines(rdline)
             call remove_character(rdline,"!")
             rdline =  strip_space(rdline)
             boundary_conditions_arg1(:,1) = rdline
          end if

          if (rdline.EQ.string1(2)) then
            read(12,'(A)',iostat=filestat), rdline
            call skip_blank_lines(rdline)
            call remove_character(rdline,"!")
            rdline =  strip_space(rdline)
            call split_inline_argument(rdline,boundary_conditions_arg2,num_of_dirichelet)
          endif

          if (rdline.EQ.string1(3)) then
            read(12,'(A)',iostat=filestat), rdline
            call skip_blank_lines(rdline)
            call remove_character(rdline,"!")
            rdline =  strip_space(rdline)
            call split_inline_argument(rdline,boundary_conditions_arg3,num_of_traction_neumann)
          end if

          if (rdline.EQ.string1(4)) then
            read(12,'(A)',iostat=filestat), rdline
            call skip_blank_lines(rdline)
            call remove_character(rdline,"!")
            rdline =  strip_space(rdline)
            call split_inline_argument(rdline,boundary_conditions_arg4,num_of_pressure_neumann)
          end if


      end do readline

    end if   !! if (trim(rdline)=="END_BOUNDARY_CONDITIONS")

  end subroutine BC_parsing_subroutine

  !!!!!!!!!!!!!!!!!!!!!!!! FOLLOWING SUBROUTINE PARSE "MATERIAL BLOCK"  IN INPUT FILE. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!!!!!!!!!!!!!!!!!!!!!!! FOR COMMENTS PLEASE REFER TO THE "Field_parsing_subroutine."  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  subroutine   MaterialField_parsing_subroutine(string1,MaterialField_arg1,MaterialField_arg2,rdline)
                                              

    integer                                            :: i,filestat,n,stat,k,pos1,pos2
    character(len=100) , dimension(:,:),allocatable    :: MaterialField_arg1,MaterialField_arg2
    character(len=100)                                 :: rdline,g
    character(len=100),   dimension(:)                 :: string1
 


    if (trim(rdline)=="START_MATERIAL_FIELD") then

      readline:do

        read(12,'(A)',iostat=filestat), rdline
        rdline =  strip_space(rdline)
        call remove_character(rdline,"!")

        if (trim(rdline)=="END_MATERIAL_FIELD") exit

        if (rdline.EQ.string1(1)) then
          read(12,'(A)',iostat=filestat), rdline
          call skip_blank_lines(rdline)
          call remove_character(rdline,"!")
          rdline =  strip_space(rdline)
          MaterialField_arg1(:,1) = rdline
        end if


        if (rdline.EQ.string1(2)) then
          read(12,'(A)',iostat=filestat), rdline
          call skip_blank_lines(rdline)
          call remove_character(rdline,"!")
          rdline =  strip_space(rdline)
          call split_inline_argument(rdline,MaterialField_arg2)
        end if

      end do readline

    end if

  end subroutine MaterialField_parsing_subroutine



  !!!!!!!!!!!!!!!!!!!!!!!! FOLLOWING SUBROUTINE PARSE "FiberFIeld BLOCK"  IN INPUT FILE. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!!!!!!!!!!!!!!!!!!!!!!! FOR COMMENTS PLEASE REFER TO THE "Field_parsing_subroutine."  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  subroutine   FiberField_parsing_subroutine(string1,FiberField_arg1,FiberField_arg2, rdline)
                                           

    integer                                            :: i,filestat,n,stat,k,pos1,pos2
    character(len=100) , dimension(:,:),allocatable    :: FiberField_arg1,FiberField_arg2
    character(len=100)                                 :: rdline,g
    character(len=100),   dimension(:)                 :: string1
 


    if (trim(rdline)=="START_FIBER_FIELD") then


      readline:do

        read(12,'(A)',iostat=filestat), rdline
        rdline =  strip_space(rdline)
        call remove_character(rdline,"!")

        if (trim(rdline)=="END_FIBER_FIELD") exit

        if (rdline.EQ.string1(1)) then
          read(12,'(A)',iostat=filestat), rdline
          call skip_blank_lines(rdline)
          call remove_character(rdline,"!")
          rdline =  strip_space(rdline)
          FiberField_arg1(:,1) = rdline
        end if

        if (rdline.EQ.string1(2)) then
          read(12,'(A)',iostat=filestat), rdline
          call skip_blank_lines(rdline)
          call remove_character(rdline,"!")
          rdline =  strip_space(rdline)
          call split_inline_argument(rdline,FiberField_arg2)
        end if


      end do readline

    end if

  end subroutine FiberField_parsing_subroutine

  !!!!!!!!!!!!!!!!!!!!!!!! FOLLOWING SUBROUTINE PARSE "Equation Set BLOCK"  IN INPUT FILE. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!!!!!!!!!!!!!!!!!!!!!!! FOR COMMENTS PLEASE REFER TO THE "Field_parsing_subroutine."  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  subroutine   Equations_Set_parsing(string1,EquationsSet_arg1,EquationsSet_arg2,EquationsSet_arg3, EquationsSet_arg4, rdline)
                                   

    integer                                            :: i,filestat,n,stat,k
    character(len=100) , dimension(:,:),allocatable    :: EquationsSet_arg1,EquationsSet_arg2,EquationsSet_arg3,&
                                                       &EquationsSet_arg4
    character(len=100)                                 :: rdline,g
    character(len=100),   dimension(:)                 :: string1



    if (trim(rdline)=="START_EQUATIONS_SET") then


      readline:do


        read(12,'(A)',iostat=filestat), rdline
        if (trim(rdline)=="END_EQUATIONS_SET") exit
        rdline =  strip_space(rdline)
        call remove_character(rdline,"!")

        if (rdline.EQ.string1(1)) then
          read(12,'(A)',iostat=filestat), rdline
          call skip_blank_lines(rdline)
          call remove_character(rdline,"!")
          rdline =  strip_space(rdline)
          EquationsSet_arg1(:,1) = rdline
        end if

        if (rdline.EQ.string1(2)) then
          read(12,'(A)',iostat=filestat), rdline
          call skip_blank_lines(rdline)
          call remove_character(rdline,"!")
          rdline =  strip_space(rdline)
          EquationsSet_arg2(:,1) = rdline
        endif

        if (rdline.EQ.string1(3)) then
          read(12,'(A)',iostat=filestat), rdline
          call skip_blank_lines(rdline)
          call remove_character(rdline,"!")
          rdline =  strip_space(rdline)
          EquationsSet_arg3(:,1) = rdline
        endif

        if (rdline.EQ.string1(4)) then
          read(12,'(A)',iostat=filestat), rdline
          call skip_blank_lines(rdline)
          call remove_character(rdline,"!")
          rdline =  strip_space(rdline)
          EquationsSet_arg4(:,1) = rdline
        endif


      end do readline

    end if

  end subroutine Equations_Set_parsing

  !!!!!!!!!!!!!!!!!!!!!!!! FOLLOWING SUBROUTINE PARSE "PROBLEM BLOCK"  IN INPUT FILE. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!!!!!!!!!!!!!!!!!!!!!!! FOR COMMENTS PLEASE REFER TO THE "Field_parsing_subroutine."  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  subroutine   Problem_parsing_subroutine(string1,Problem_arg1,Problem_arg2,Problem_arg3,Problem_arg4, rdline)
                                       

    integer                                            :: i,filestat,n,stat,k
    character(len=100) , dimension(:,:),allocatable    :: Problem_arg1,Problem_arg2,Problem_arg3,Problem_arg4
    character(len=100)                                 :: rdline,g
    character(len=100),   dimension(:)                 :: string1




    if (trim(rdline)=="START_PROBLEM") then


      readline:do

        read(12,'(A)',iostat=filestat), rdline

        if (trim(rdline)=="END_PROBLEM") exit
        rdline =  strip_space(rdline)
        call remove_character(rdline,"!")

        if (rdline.EQ.string1(1)) then
          read(12,'(A)',iostat=filestat), rdline
          rdline =  strip_space(rdline)
          Problem_arg1(:,1) = rdline
        end if

        if (rdline.EQ.string1(2)) then
          read(12,'(A)',iostat=filestat), rdline
          rdline =  strip_space(rdline)
          Problem_arg2(:,1) = rdline
        endif

        if (rdline.EQ.string1(3)) then
          read(12,'(A)',iostat=filestat), rdline
          rdline =  strip_space(rdline)
          Problem_arg3(:,1) = rdline
        endif

        if (rdline.EQ.string1(4)) then
          read(12,'(A)',iostat=filestat), rdline
       	  rdline =  strip_space(rdline)
          Problem_arg4(:,1) = rdline
        endif

      end do readline

    end if

  end subroutine Problem_parsing_subroutine

  !!!!!!!!!!!!!!!!!!!!!!!! FOLLOWING SUBROUTINE PARSE "MESH BLOCK"  IN INPUT FILE. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!!!!!!!!!!!!!!!!!!!!!!! FOR COMMENTS PLEASE REFER TO THE "Field_parsing_subroutine."  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  subroutine   Mesh_parsing_subroutine(string1,Mesh_arg1,Mesh_arg2,Mesh_arg3,Mesh_arg4,rdline)

    integer                                            :: i,filestat,n,stat,k,pos1,pos2
    character(len=100) , dimension(:,:),allocatable    :: Mesh_arg1,Mesh_arg2,Mesh_arg3,Mesh_arg4 ,Mesh_arg5
    character(len=100)                                 :: rdline,g
    character(len=100),   dimension(:)                 :: string1
 


    if (trim(rdline)=="START_MESH") then


      readline:do

        read (12,'(A)',iostat=filestat), rdline
        rdline =  strip_space(rdline)
        call remove_character(rdline,"!")


        if (trim(rdline)=="END_MESH") exit

        if (rdline.EQ.string1(1)) then
          read(12,'(A)',iostat=filestat), rdline
          call skip_blank_lines(rdline)
          call remove_character(rdline,"!")
          rdline =  strip_space(rdline)
          Mesh_arg1(:,1) = rdline
        end if

        if (rdline.EQ.string1(2)) then
          read(12,'(A)',iostat=filestat), rdline
          call skip_blank_lines(rdline)
          call remove_character(rdline,"!")
          rdline =  strip_space(rdline)
          Mesh_arg2(:,1) = rdline
        end if

        if (rdline.EQ.string1(3)) then
          read(12,'(A)',iostat=filestat), rdline
          call skip_blank_lines(rdline)
          call remove_character(rdline,"!")
          rdline =  strip_space(rdline)
          call split_inline_argument(rdline,Mesh_arg3)
        end if


        if (rdline.EQ.string1(4)) then
          read(12,'(A)',iostat=filestat), rdline
  	  call skip_blank_lines(rdline)
          rdline =  strip_space(rdline)
          call remove_character(rdline,"!")
          k = 0
          pos1 = 1
          DO
       	    pos2 = INDEX(rdline(pos1:), ",")
    	    IF (pos2 == 0) THEN
       	      k = k + 1
       	      Mesh_arg4(k,1) = rdline(pos1:)
              EXIT
            END IF
            k = k + 1
            Mesh_arg4(k,1) = rdline(pos1:pos1+pos2-2)
            pos1 = pos2+pos1
   	  END DO
        end if

      end do readline

    end if
  
  end subroutine Mesh_parsing_subroutine




  !!!!!!!!!!!!!!!!!!!!!!!!! FOLLOWING SUBROUTINE PARSE VERY BLOCK WITH SCALAR INPUTS     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


  SUBROUTINE  parsing_subroutine(string,arguments,rdline,num_of_arguments,string_tobe_parsed)

 
    character(len=100),dimension(:,:)          :: arguments
    character(len=100)                         :: rdline
    character(len=100),dimension(:)            :: string
    character(len=*)                           :: string_tobe_parsed
    integer                                    :: m,num_of_arguments


    if (trim(rdline)=="START_"// trim(string_tobe_parsed)) then

      readline:do

        read(12,'(A)',iostat=filestat), rdline
        rdline =  strip_space(rdline)
        call remove_character(rdline,"!")
        ! terminate upon encoutering END_start_string
        if (trim(rdline)=="END_" // string_tobe_parsed ) exit

        if ( (trim(rdline).NE."") .AND.  (trim(rdline(:1)).NE."!")) then
          do m = 1,num_of_arguments
            if ((trim(rdline)).EQ.string(m))  then
            read(12,'(A)',iostat=filestat), arguments(m,1)
            exit
            end if
          end do

        end if

      end do readline
    end if


  END SUBROUTINE  parsing_subroutine




  !!!!!!!!!!!!!!!!!!!!! THE FOLLOWING SUBROUTINE COUNTS THE NUMBER OF TIMES A KEYWORD EXIST IN THE INPUT FILE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  SUBROUTINE  searching(rdline,search_string,counter)

    !!!! initializing values
 

    character(len=100)                         :: rdline
    character(len=*)                           :: search_string
    integer                                    :: counter

    rdline =  strip_space(rdline)
    if (trim(rdline)==search_string) counter = counter+1

  END SUBROUTINE  searching




  !!!!!!!!!!!REMOVE PROCEEDING , RECEEDING SPACES AND SPACES INBETWEEN CHARACTERS INSIDE A STRING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


  FUNCTION strip_space( input_string ) RESULT ( output_string )

    ! -- Arguments
    CHARACTER( * ), INTENT( IN )  :: input_string
    INTEGER                       :: n

    ! -- Function result
    CHARACTER( LEN( input_string ) ) :: output_string

    ! -- Local parameters
    INTEGER,        PARAMETER :: IACHAR_SPACE = 32, &
                                 IACHAR_TAB   = 9

    ! -- Local variables
    INTEGER :: i
    INTEGER :: iachar_character

    ! -- Initialise output string
    output_string = ' '

    ! -- Initialise output string "useful" length counter
    n = 0

    ! -- Loop over string elements
    DO i = 1, LEN( input_string )

      ! -- Convert the current character to its position
      ! -- in the ASCII collating sequence
      iachar_character = IACHAR( input_string( i:i ) )

      ! -- If the character is NOT a space ' ' or a tab '->|'
      ! -- copy it to the output string.
      IF ( iachar_character /= IACHAR_SPACE .AND. &
           iachar_character /= IACHAR_TAB         ) THEN
        n = n + 1
        output_string( n:n ) = input_string( i:i )
      END IF

    END DO


  END FUNCTION strip_space



  !!!!!!!!!!!!!!!!!!!!! THE FOLLOWING FUNCTION... !!!!!!!!!!!!!!!!!!!!!!
  !!!!!         REMOVE SPECIFIED CHARACTER FROM A STRING!!!!!!!!!!!!!!!!



  subroutine remove_character(string,character)
    implicit none
    integer :: ind
    character(len=100)  :: string
    character           :: character
    ind = SCAN(string, character)
    if (ind .NE.0) then
      string = string(:ind-1)
    end if
  end subroutine remove_character




  !!!!!CONVERT STRING TO REAL NUMBER !!!!!!!!!!!!!! !!!!!!!!!!!!!!!!!!!!



  REAL(CMISSRP) function str2real(str_2)
    implicit none
    ! Arguments
    character(len=*)      :: str_2
    read(str_2,*,iostat=stat)  str2real
  end function str2real


  !!!!!CONVERT STRING TO INTEGER NUMBER !!!!!!!!!!!!!! !!!!!!!!!!!!!!!!

  integer function str2int(str)
    implicit none
    ! Arguments
    character(len=*)      :: str
    read(str,*,iostat=stat)  str2int
  end function str2int
  
  !!!!!Skip blank lines in the input file !!!!!!!!!!!!!! !!!!!!!!!!!!!!!!

  subroutine skip_blank_lines(rdline)

    
    integer :: filestat
    character(len=100)              :: rdline

    do
      if (rdline .NE."") exit
      read(12,*) rdline
    end do

  end subroutine skip_blank_lines


  !!!!!!!!!!!!!!!!!!!!!!!!!! The following subroutine splits a comma separated string !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  subroutine split_inline_argument(rdline,array1,i)

    
    integer :: k,pos2,pos1
    integer,optional::i
    character(len=100)  :: rdline
    character(len=100) , dimension(:,:),allocatable :: array1
    k=0
    DO

        pos1 = 1
        DO
            pos2 = INDEX(rdline(pos1:), ",")
            IF (pos2 == 0) THEN
                k = k + 1
                array1(k,1) = rdline(pos1:)
                EXIT
            END IF
            k = k + 1
            array1(k,1) = rdline(pos1:pos1+pos2-2)
            pos1 = pos2+pos1
        END DO

        if (rdline == "") exit
        read(12,'(A)') rdline
        rdline =  strip_space(rdline)
        call remove_character(rdline,"!")
        if(present(i)) i=i+1
   END DO

  end subroutine split_inline_argument


end module parsing
