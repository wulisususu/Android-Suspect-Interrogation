.class Lcom/taobao/tao/log/TLogNative$XLoggerInfo;
.super Ljava/lang/Object;
.source "TLogNative.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/TLogNative;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "XLoggerInfo"
.end annotation


# instance fields
.field public clientID:Ljava/lang/String;

.field public filename:Ljava/lang/String;

.field public funcname:Ljava/lang/String;

.field public level:I

.field public line:I

.field public log:Ljava/lang/String;

.field public maintid:J

.field public module:Ljava/lang/String;

.field public pid:J

.field public serverID:Ljava/lang/String;

.field public tag:Ljava/lang/String;

.field public tid:J

.field public type:Ljava/lang/String;


# direct methods
.method constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
