.class public final synthetic Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda2;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/getcapacitor/PluginCall;


# direct methods
.method public synthetic constructor <init>(Lcom/getcapacitor/PluginCall;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda2;->f$0:Lcom/getcapacitor/PluginCall;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    iget-object v0, p0, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda2;->f$0:Lcom/getcapacitor/PluginCall;

    invoke-static {v0}, Lplugins/MultiScreenPlugin/MultiScreenPlugin;->lambda$terminate$2(Lcom/getcapacitor/PluginCall;)V

    return-void
.end method
