.class public final synthetic Lplugins/NoTrouble/NoTroublePlugin$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Lplugins/NoTrouble/NoTroublePlugin;

.field public final synthetic f$1:Lcom/getcapacitor/PluginCall;


# direct methods
.method public synthetic constructor <init>(Lplugins/NoTrouble/NoTroublePlugin;Lcom/getcapacitor/PluginCall;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lplugins/NoTrouble/NoTroublePlugin$$ExternalSyntheticLambda1;->f$0:Lplugins/NoTrouble/NoTroublePlugin;

    iput-object p2, p0, Lplugins/NoTrouble/NoTroublePlugin$$ExternalSyntheticLambda1;->f$1:Lcom/getcapacitor/PluginCall;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 2

    iget-object v0, p0, Lplugins/NoTrouble/NoTroublePlugin$$ExternalSyntheticLambda1;->f$0:Lplugins/NoTrouble/NoTroublePlugin;

    iget-object v1, p0, Lplugins/NoTrouble/NoTroublePlugin$$ExternalSyntheticLambda1;->f$1:Lcom/getcapacitor/PluginCall;

    check-cast p1, Ljava/lang/Boolean;

    invoke-static {v0, v1, p1}, Lplugins/NoTrouble/NoTroublePlugin;->$r8$lambda$NQXhh17xki1f3m2eyiq1pXkyv0w(Lplugins/NoTrouble/NoTroublePlugin;Lcom/getcapacitor/PluginCall;Ljava/lang/Boolean;)V

    return-void
.end method
