.class public final synthetic Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda4;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Landroid/app/Activity;

.field public final synthetic f$1:Landroid/view/Display;

.field public final synthetic f$2:Ljava/lang/String;

.field public final synthetic f$3:Lcom/getcapacitor/PluginCall;


# direct methods
.method public synthetic constructor <init>(Landroid/app/Activity;Landroid/view/Display;Ljava/lang/String;Lcom/getcapacitor/PluginCall;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda4;->f$0:Landroid/app/Activity;

    iput-object p2, p0, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda4;->f$1:Landroid/view/Display;

    iput-object p3, p0, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda4;->f$2:Ljava/lang/String;

    iput-object p4, p0, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda4;->f$3:Lcom/getcapacitor/PluginCall;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 4

    iget-object v0, p0, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda4;->f$0:Landroid/app/Activity;

    iget-object v1, p0, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda4;->f$1:Landroid/view/Display;

    iget-object v2, p0, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda4;->f$2:Ljava/lang/String;

    iget-object v3, p0, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda4;->f$3:Lcom/getcapacitor/PluginCall;

    invoke-static {v0, v1, v2, v3}, Lplugins/MultiScreenPlugin/MultiScreenPlugin;->lambda$open$1(Landroid/app/Activity;Landroid/view/Display;Ljava/lang/String;Lcom/getcapacitor/PluginCall;)V

    return-void
.end method
