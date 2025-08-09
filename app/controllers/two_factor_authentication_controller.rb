# app/controllers/two_factor_authentication_controller.rb
require 'rqrcode'

class TwoFactorAuthenticationController < ApplicationController
  before_action :authenticate_user!

  def show
    @qr_code = RQRCode::QRCode.new(current_user.otp_provisioning_uri(current_user.email))
  end

  def create
    if current_user.authenticate_otp(params[:verification_code])
      current_user.update(otp_required_for_login: true)
      redirect_to root_path, notice: "Two-factor authentication has been enabled."
    else
      flash.now[:alert] = "Invalid verification code."
      render :show, status: :unprocessable_entity
    end
  end
end
