classdef fccr_bbblueIMU < matlab.System ...
        & matlab.system.mixin.internal.CustomIcon ...
        & matlab.system.mixin.Propagates ...
        & matlabshared.svd.BlockSampleTime ...
        & coder.ExternalDependency
    
    % Beaglebone Blue IMU
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.
    
    %#codegen
    %#ok<*EMCA>
    
    properties(Nontunable)
        
    end
    
    properties(Constant, Hidden)
        blockPlatform = 'BB BLUE'
    end
    
    properties(Hidden)
        
    end
    
    methods
        % Constructor
        function obj = fccr_bblueIMU(varargin)
            %This would allow the code generation to proceed with the
            %p-files in the installed location of the support package.
            coder.allowpcode('plain');
            % Support name-value pair arguments when constructing the object.
            setProperties(obj,nargin,varargin{:});
        end
        
    end
    
    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
            if coder.target('Rtw')
                coder.cinclude('fccr_bbblue_driver.h');
                coder.updateBuildInfo('addDefines','_roboticscape_in_use_');
                coder.ceval('fccr_initialize_imu');
            end
        end
        
        function [accel_x, accel_y, accel_z, gyro_x, gyro_y, gyro_z] = stepImpl(~)
            % Implement algorithm. Calculate y as a function of input u and
            %  discrete states.
            
            accel_x = double(0);
            accel_y = double(0);
            accel_z = double(0);
            gyro_x = double(0);
            gyro_y = double(0);
            gyro_z = double(0);
            
            if coder.target('Rtw')
               accel_x = coder.ceval('fccr_read_accel_x');
               accel_y = coder.ceval('fccr_read_accel_y');
               accel_z = coder.ceval('fccr_read_accel_z');
               gyro_x = coder.ceval('fccr_read_gyro_x');
               gyro_y = coder.ceval('fccr_read_gyro_y');
               gyro_z = coder.ceval('fccr_read_gyro_z');
            end
        end
        
        function releaseImpl(~)
            % Release resources, such as file handles
            if coder.target('Rtw')
                coder.ceval('rc_power_off_imu'); % Power down IMU at end of simulation
            end
        end
        
        function num = getNumInputsImpl(~)
            % Define total number of inputs for system with optional inputs
            num = 0;
            % if obj.UseOptionalInput
            %     num = 2;
            % end
        end
        
        function num = getNumOutputsImpl(~)
            % Define total number of outputs for system with optional
            % outputs
            num = 6;
        end

        function varargout = getOutputNamesImpl(~)
            % Return output port names for System block
            varargout{1} = 'Accel_x';
            varargout{2} = 'Accel_y';
            varargout{3} = 'Accel_z';
            varargout{4} = 'Gyro_x';
            varargout{5} = 'Gyro_y';
            varargout{6} = 'Gyro_z';
        end
        
        function varargout = getOutputSizeImpl(~)
            % Return size for each output port
            varargout{1} = [1 1];
            varargout{2} = [1 1];
            varargout{3} = [1 1];
            varargout{4} = [1 1];
            varargout{5} = [1 1];
            varargout{6} = [1 1];
        end
        
        function varargout = getOutputDataTypeImpl(~)
            % Return data type for each output port
            varargout{1} = 'double';
            varargout{2} = 'double';
            varargout{3} = 'double';
            varargout{4} = 'double';
            varargout{5} = 'double';
            varargout{6} = 'double';
        end
        
        function varargout = isOutputComplexImpl(~)
            % Return true for each output port with complex data
            varargout{1} = false;
            varargout{2} = false;
            varargout{3} = false;
            varargout{4} = false;
            varargout{5} = false;
            varargout{6} = false;
        end
        
        function varargout = isOutputFixedSizeImpl(~)
            % Return true for each output port with fixed size
            varargout{1} = true;
            varargout{2} = true;
            varargout{3} = true;
            varargout{4} = true;
            varargout{5} = true;
            varargout{6} = true;
        end
        
        function st = getSampleTimeImpl(obj)
            st = obj.SampleTime;
        end

        function maskDisplayCmds = getMaskDisplayImpl(obj)
            blockName = 'IMU';
            maskDisplayCmds = [ ...
                ['color(''white'');',newline]...
                ['plot([100,100,100,100]*1,[100,100,100,100]*1);',newline]...
                ['plot([100,100,100,100]*0,[100,100,100,100]*0);',newline]...                
                ['color(''blue'');',newline] ...
                ['text(100, 92, '' ' obj.blockPlatform ' '', ''horizontalAlignment'', ''right'');',newline]  ...
                ['color(''black'');',newline]...
                ['text(52,52,' [''' ' blockName ''',''horizontalAlignment'',''center'');' newline]]   ...
                ['color(''black'');',newline]...
                ];
        end
        
    end %methods
    
    methods (Static)
        function name = getDescriptiveName()
            name = 'BeagleBone Blue IMU';
        end
        
        function b = isSupportedContext(context)
            b = context.isCodeGenTarget('rtw');
        end
        
        function updateBuildInfo(buildInfo, context)
            if context.isCodeGenTarget('rtw')
               spkgRootDir = codertarget.bbblue.internal.getSpPkgRootDir;
                % Include Paths
                addIncludePaths(buildInfo, fullfile(spkgRootDir, 'include'));
                addIncludeFiles(buildInfo, 'MW_bbblue_driver.h');
                addIncludeFiles(buildInfo, 'fccr_bbblue_driver.h');
                
                % Update buildInfo
                rootDir = fullfile(fileparts(mfilename('fullpath')),'.');
                buildInfo.addIncludePaths(rootDir);
                
                % Source Files
                systemTargetFile = get_param(buildInfo.ModelName,'SystemTargetFile');
                if isequal(systemTargetFile,'ert.tlc')
                    % Add the following when not in rapid-accel simulation
                    buildInfo.addLinkFlags('-lroboticscape');
                    addSourcePaths(buildInfo, fullfile(spkgRootDir, 'src'));
                    addSourceFiles(buildInfo, 'fccr_imu.c', fullfile(spkgRootDir, 'src'), 'BlockModules');
                end
                
            end
        end
    end %methods
    
    methods(Access = protected, Static)
        function simMode = getSimulateUsingImpl(~)
            simMode = 'Interpreted execution';
        end
        
        function header = getHeaderImpl
            % Define header panel for System block dialog
               header = matlab.system.display.Header(mfilename('class'), ...
                'Title', 'IMU', ...
                'Text',['Output Accelerometer and Gyroscope data.'], ...
                'ShowSourceLink', false);
        end
        
        function groups = getPropertyGroupsImpl
            % Sample Time
            Sampletime = matlab.system.display.internal.Property('SampleTime', 'Description', 'Sample time');
            
            PropertyListOut = {Sampletime};
            % Create mask display
            Group = matlab.system.display.Section(...
                'PropertyList',PropertyListOut);
            
            groups = Group;
            
        end
        
        function flag = showSimulateUsingImpl
            % Return false if simulation mode hidden in System block dialog
            flag = false;
        end
    end
end
