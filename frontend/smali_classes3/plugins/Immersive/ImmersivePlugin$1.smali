.class Lplugins/Immersive/ImmersivePlugin$1;
.super Landroid/telephony/PhoneStateListener;
.source "ImmersivePlugin.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lplugins/Immersive/ImmersivePlugin;->load()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lplugins/Immersive/ImmersivePlugin;


# direct methods
.method constructor <init>(Lplugins/Immersive/ImmersivePlugin;)V
    .locals 0

    iput-object p1, p0, Lplugins/Immersive/ImmersivePlugin$1;->this$0:Lplugins/Immersive/ImmersivePlugin;

    .line 58
    invoke-direct {p0}, Landroid/telephony/PhoneStateListener;-><init>()V

    return-void
.end method


# virtual methods
.method public onSignalStrengthsChanged(Landroid/telephony/SignalStrength;)V
    .locals 1

    iget-object v0, p0, Lplugins/Immersive/ImmersivePlugin$1;->this$0:Lplugins/Immersive/ImmersivePlugin;

    .line 61
    invoke-virtual {p1}, Landroid/telephony/SignalStrength;->getLevel()I

    move-result p1

    invoke-static {v0, p1}, Lplugins/Immersive/ImmersivePlugin;->-$$Nest$fputsignalStrengthValue(Lplugins/Immersive/ImmersivePlugin;I)V

    return-void
.end method
