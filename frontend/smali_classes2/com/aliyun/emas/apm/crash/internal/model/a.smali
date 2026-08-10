.class public final Lcom/aliyun/emas/apm/crash/internal/model/a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/firebase/encoders/config/Configurator;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/internal/model/a$f;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$j;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$a;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$e;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$y;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$i;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$k;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$x;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$s;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$l;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$m;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$o;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$p;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$n;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$c;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$b;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$g;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$h;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$d;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$q;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$r;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$t;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$w;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$u;,
        Lcom/aliyun/emas/apm/crash/internal/model/a$v;
    }
.end annotation


# static fields
.field public static final a:Lcom/google/firebase/encoders/config/Configurator;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/a;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/internal/model/a;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a;->a:Lcom/google/firebase/encoders/config/Configurator;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public configure(Lcom/google/firebase/encoders/config/EncoderConfig;)V
    .locals 2

    .line 1
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$f;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$f;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 2
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/b;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 3
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$j;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$j;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 4
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/k;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 5
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$a;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$a;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 6
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/c;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 7
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$e;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$e;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 8
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/g;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 9
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$y;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$y;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$User;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 10
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/z;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 11
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$i;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$i;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Network;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 12
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/j;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 13
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$k;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$k;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 14
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/l;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 15
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$x;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$x;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 16
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/y;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 17
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$s;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 18
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/m;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 19
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$l;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$l;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 20
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/n;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 21
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$m;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$m;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 22
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/o;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 23
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$o;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$o;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 24
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/q;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 25
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$p;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$p;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 26
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/r;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 27
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$n;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$n;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 28
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/p;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 29
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$c;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$c;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 30
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/d;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 31
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$b;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$b;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$BuildIdMappingForArch;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 32
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/e;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 33
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$g;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$g;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 34
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/h;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 35
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$h;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$h;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 36
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/i;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 37
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$d;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$d;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$CustomAttribute;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 38
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/f;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 39
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$q;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$q;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 40
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/s;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 41
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$r;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$r;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 42
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/t;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 43
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$t;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$t;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 44
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/u;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 45
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$w;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$w;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 46
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/x;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 47
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$u;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$u;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 48
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/v;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 49
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$v;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$v;

    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutAssignment$RolloutVariant;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    .line 50
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/model/w;

    invoke-interface {p1, v1, v0}, Lcom/google/firebase/encoders/config/EncoderConfig;->registerEncoder(Ljava/lang/Class;Lcom/google/firebase/encoders/ObjectEncoder;)Lcom/google/firebase/encoders/config/EncoderConfig;

    return-void
.end method
